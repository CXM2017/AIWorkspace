param(
    [string]$VaultRoot = "E:\AIWorkspace\CxMVault",
    [string]$SourceVault = "E:\CodeXData\CodeXKnowledge",
    [string]$SourceMemory = "E:\CodeXData\agentMemory",
    [string]$ReportPath = "",
    [switch]$NoWrite
)

$ErrorActionPreference = "Stop"

function Add-Issue {
    param(
        [System.Collections.Generic.List[object]]$Issues,
        [string]$Severity,
        [string]$Area,
        [string]$Path,
        [string]$Message
    )

    $Issues.Add([pscustomobject]@{
        Severity = $Severity
        Area = $Area
        Path = $Path
        Message = $Message
    }) | Out-Null
}

function Test-ReplacementChar {
    param([string]$Path)
    $text = Get-Content -Raw -LiteralPath $Path
    return ($text -match [char]0xFFFD)
}

function Convert-FlatYamlScalar {
    param([AllowNull()][string]$Value)

    if ($null -eq $Value) {
        return $null
    }

    $trimmed = $Value.Trim()
    if ($trimmed -eq "null") {
        return $null
    }
    if (
        $trimmed.Length -ge 2 -and
        (
            ($trimmed.StartsWith("'") -and $trimmed.EndsWith("'")) -or
            ($trimmed.StartsWith('"') -and $trimmed.EndsWith('"'))
        )
    ) {
        return $trimmed.Substring(1, $trimmed.Length - 2)
    }
    return $trimmed
}

function Get-ComparableScalar {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return "<null>"
    }
    return ([string]$Value).Trim()
}

function Get-MarkdownFrontmatter {
    param([string]$Path)

    $fields = [ordered]@{}
    $text = Get-Content -LiteralPath $Path -Raw
    $match = [regex]::Match($text, "\A---\s*\r?\n(?<body>.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $match.Success) {
        return $fields
    }

    foreach ($line in ($match.Groups["body"].Value -split "\r?\n")) {
        if ($line -match "^([a-z][a-z0-9_]*)\s*:\s*(.*?)\s*$") {
            $fields[$Matches[1]] = Convert-FlatYamlScalar $Matches[2]
        }
    }
    return $fields
}

function Get-FlatRegistryProjects {
    param([string]$RegistryText)

    $projects = [System.Collections.Generic.List[object]]::new()
    $current = $null
    $inProjects = $false

    foreach ($line in ($RegistryText -split "\r?\n")) {
        if (-not $inProjects) {
            if ($line -match "^projects\s*:\s*$") {
                $inProjects = $true
            }
            continue
        }

        if ($line -match "^  - ([a-z][a-z0-9_]*)\s*:\s*(.*?)\s*$") {
            if ($null -ne $current) {
                $projects.Add($current) | Out-Null
            }
            $current = [ordered]@{}
            $current[$Matches[1]] = Convert-FlatYamlScalar $Matches[2]
            continue
        }
        if ($line -match "^    ([a-z][a-z0-9_]*)\s*:\s*(.*?)\s*$") {
            if ($null -ne $current) {
                $current[$Matches[1]] = Convert-FlatYamlScalar $Matches[2]
            }
            continue
        }
        if ($line -match "^\S") {
            break
        }
    }

    if ($null -ne $current) {
        $projects.Add($current) | Out-Null
    }
    return $projects
}

function Get-FrontmatterDate {
    param(
        [System.Collections.IDictionary]$Frontmatter,
        [string[]]$Fields
    )

    foreach ($field in $Fields) {
        if (-not $Frontmatter.Contains($field)) {
            continue
        }
        $value = Get-ComparableScalar $Frontmatter[$field]
        $parsed = [datetime]::MinValue
        if (
            [datetime]::TryParseExact(
                $value,
                "yyyy-MM-dd",
                [System.Globalization.CultureInfo]::InvariantCulture,
                [System.Globalization.DateTimeStyles]::None,
                [ref]$parsed
            )
        ) {
            return $parsed.Date
        }
    }
    return $null
}

if (-not (Test-Path -LiteralPath $VaultRoot -PathType Container)) {
    throw "VaultRoot not found: $VaultRoot"
}

$VaultRoot = (Resolve-Path -LiteralPath $VaultRoot).Path
if ([string]::IsNullOrWhiteSpace($ReportPath)) {
    $ReportPath = Join-Path $VaultRoot "outputs\reports\CxMVault-health-report.md"
}

$issues = [System.Collections.Generic.List[object]]::new()

$requiredDirs = @(
    ".obsidian",
    "raw",
    "raw\legacy\codexknowledge",
    "raw\legacy\agentmemory-index",
    "raw\inbox",
    "raw\personal",
    "raw\projects",
    "wiki",
    "wiki\personal",
    "wiki\projects",
    "wiki\domains",
    "wiki\concepts",
    "wiki\operations",
    "reviews",
    "reviews\daily",
    "reviews\weekly",
    "reviews\monthly",
    "templates",
    "schema",
    "schema\adapters",
    "views",
    "logs",
    "outputs",
    "outputs\reports",
    "outputs\graphs",
    "outputs\exports",
    "tools"
)
foreach ($dir in $requiredDirs) {
    if (-not (Test-Path -LiteralPath (Join-Path $VaultRoot $dir) -PathType Container)) {
        Add-Issue $issues "error" "structure" $dir "缺少目录"
    }
}

$requiredFiles = @(
    "README.md",
    "00-开始使用.md",
    "raw\README.md",
    "raw\inbox\web\README.md",
    "raw\inbox\articles\README.md",
    "raw\inbox\screenshots\README.md",
    "raw\inbox\files\README.md",
    "raw\inbox\ideas\README.md",
    "wiki\README.md",
    "reviews\README.md",
    "templates\README.md",
    "schema\README.md",
    "logs\README.md",
    "outputs\README.md",
    "tools\README.md",
    "wiki\overview.md",
    "wiki\index.md",
    "wiki\log.md",
    "wiki\operations\采集消化复盘SOP.md",
    "wiki\operations\新知识库搭建与验收流程.md",
    "schema\AGENTS.md",
    "schema\adapters\CLAUDE.md",
    "schema\adapters\HERMES.md",
    "raw\inbox\README.md",
    "reviews\daily\README.md",
    "reviews\weekly\README.md",
    "reviews\monthly\README.md",
    "templates\Inbox Item.md",
    "templates\Daily Note.md",
    "templates\Weekly Review.md",
    "templates\Monthly Review.md",
    "templates\Wiki Page.md",
    "raw\legacy\codexknowledge\index.md",
    "raw\legacy\agentmemory-index\index.md",
    "wiki\operations\旧库迁移策略.md",
    "wiki\operations\Obsidian配置迁移.md",
    "wiki\operations\知识维护闭环.md",
    "schema\projects.yaml",
    "tools\Initialize-CxMVault.ps1",
    "tools\Test-CxMVault.ps1",
    "views\Project Registry.base",
    "views\Inbox Review.base"
)
foreach ($file in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $VaultRoot $file) -PathType Leaf)) {
        Add-Issue $issues "error" "structure" $file "缺少核心文件"
    }
}

$pluginsRoot = Join-Path $VaultRoot ".obsidian\plugins"
$installedPlugins = @()
if (Test-Path -LiteralPath $pluginsRoot -PathType Container) {
    $installedPlugins = @(
        Get-ChildItem -LiteralPath $pluginsRoot -Directory |
            Where-Object {
                Test-Path -LiteralPath (Join-Path $_.FullName "manifest.json") -PathType Leaf
            } |
            ForEach-Object Name |
            Sort-Object -Unique
    )
}
else {
    Add-Issue $issues "error" "obsidian" ".obsidian\plugins" "缺少社区插件目录"
}

$enabledPlugins = @()
$communityPath = Join-Path $VaultRoot ".obsidian\community-plugins.json"
if (Test-Path -LiteralPath $communityPath -PathType Leaf) {
    try {
        $enabledPlugins = @(
            Get-Content -LiteralPath $communityPath -Raw |
                ConvertFrom-Json |
                ForEach-Object { [string]$_ } |
                Sort-Object -Unique
        )
    }
    catch {
        Add-Issue $issues "error" "obsidian" ".obsidian\community-plugins.json" "社区插件启用列表不是有效 JSON：$($_.Exception.Message)"
    }
}
else {
    Add-Issue $issues "error" "obsidian" ".obsidian\community-plugins.json" "缺少社区插件启用列表"
}

foreach ($plugin in $enabledPlugins) {
    $manifest = Join-Path (Join-Path $pluginsRoot $plugin) "manifest.json"
    if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
        Add-Issue $issues "error" "obsidian" ".obsidian\plugins\$plugin" "已启用插件缺少 manifest"
    }
}
foreach ($plugin in $installedPlugins) {
    if ($enabledPlugins -notcontains $plugin) {
        Add-Issue $issues "info" "obsidian" ".obsidian\plugins\$plugin" "插件已安装但未启用"
    }
}

$appearancePath = Join-Path $VaultRoot ".obsidian\appearance.json"
if (Test-Path -LiteralPath $appearancePath -PathType Leaf) {
    $appearance = Get-Content -LiteralPath $appearancePath -Raw | ConvertFrom-Json
    if ($appearance.cssTheme -ne "ITS Theme") {
        Add-Issue $issues "warn" "obsidian" ".obsidian\appearance.json" "当前 cssTheme 不是 ITS Theme"
    }
}
else {
    Add-Issue $issues "error" "obsidian" ".obsidian\appearance.json" "缺少外观配置"
}

foreach ($theme in @("ITS Theme", "Minimal")) {
    $themeCss = Join-Path $VaultRoot ".obsidian\themes\$theme\theme.css"
    if (-not (Test-Path -LiteralPath $themeCss -PathType Leaf)) {
        Add-Issue $issues "error" "obsidian" ".obsidian\themes\$theme" "缺少主题文件"
    }
}

$workspacePath = Join-Path $VaultRoot ".obsidian\workspace.json"
if (Test-Path -LiteralPath $workspacePath -PathType Leaf) {
    $workspaceText = Get-Content -LiteralPath $workspacePath -Raw
    if ($workspaceText -cmatch "CodeXKnowledge|70-compiled-wiki|10-projects/|E:\\CodeXData") {
        Add-Issue $issues "error" "obsidian" ".obsidian\workspace.json" "workspace 仍包含旧库页面状态"
    }
}

$recentPath = Join-Path $VaultRoot ".obsidian\plugins\recent-files-obsidian\data.json"
if (Test-Path -LiteralPath $recentPath -PathType Leaf) {
    $recentText = Get-Content -LiteralPath $recentPath -Raw
    if ($recentText -cmatch "CodeXKnowledge|70-compiled-wiki|10-projects/|E:\\CodeXData") {
        Add-Issue $issues "error" "obsidian" ".obsidian\plugins\recent-files-obsidian\data.json" "recent files 仍包含旧库页面状态"
    }
}

$claudianPath = Join-Path $VaultRoot ".obsidian\plugins\realclaudian\data.json"
if (Test-Path -LiteralPath $claudianPath -PathType Leaf) {
    $claudianText = Get-Content -LiteralPath $claudianPath -Raw
    if ($claudianText -match "conv-|tab-") {
        Add-Issue $issues "warn" "obsidian" ".obsidian\plugins\realclaudian\data.json" "Claudian 会话状态未清空"
    }
}

foreach ($project in @("matdao_api", "SteelTechnologyNode_api", "MyExcel")) {
    $bridgePath = Join-Path $VaultRoot "wiki\projects\$project.md"
    if (-not (Test-Path -LiteralPath $bridgePath -PathType Leaf)) {
        Add-Issue $issues "error" "migration" "wiki\projects\$project.md" "缺少项目桥接页"
    }
}

if (-not (Test-Path -LiteralPath $SourceVault -PathType Container)) {
    Add-Issue $issues "error" "migration" $SourceVault "旧 CodeXKnowledge 不存在"
}
if (-not (Test-Path -LiteralPath $SourceMemory -PathType Container)) {
    Add-Issue $issues "error" "migration" $SourceMemory "旧 agentMemory 不存在"
}

$registeredProjects = 0
$registryPath = Join-Path $VaultRoot "schema\projects.yaml"
$registryProjects = @()
if (Test-Path -LiteralPath $registryPath -PathType Leaf) {
    $registryText = Get-Content -LiteralPath $registryPath -Raw
    $registryLines = $registryText -split "\r?\n"
    for ($lineIndex = 0; $lineIndex -lt $registryLines.Count; $lineIndex++) {
        $line = $registryLines[$lineIndex]
        $sensitiveKey = $line -match "(?i)^\s*(password|passwd|pwd|token|secret|api[_-]?key|authorization|cookie|credential|private[_-]?key)\s*:"
        $sensitiveValue = $line -match "(?i)(Authorization:\s*Bearer\s+[A-Za-z0-9._\-]+|sk-[A-Za-z0-9]{20,}|BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY)"
        $payloadViolation = $false
        if ($line -match "(?i)^\s*([a-z0-9_-]*payload[a-z0-9_-]*)\s*:\s*(.*?)\s*$") {
            $payloadViolation = -not (
                $Matches[1] -eq "payload_storage" -and
                $Matches[2] -eq "forbidden"
            )
        }
        if ($sensitiveKey -or $sensitiveValue -or $payloadViolation) {
            Add-Issue $issues "error" "registry-security" "schema\projects.yaml:$($lineIndex + 1)" "注册表命中疑似凭据或配置 payload 模式"
        }
    }

    $registryProjects = @(Get-FlatRegistryProjects $registryText)
    $registeredProjects = $registryProjects.Count
    if ($registeredProjects -eq 0) {
        Add-Issue $issues "error" "registry" "schema\projects.yaml" "未解析到任何项目块"
    }

    $requiredProjectFields = @(
        "project_id",
        "display_name",
        "lifecycle",
        "project_kind",
        "repository_path",
        "wiki_page",
        "knowledge_tier",
        "config_source",
        "config_authority",
        "config_write_policy",
        "agentmemory_status",
        "codegraph_status",
        "verification_status"
    )

    $contractText = $registryText
    $projectsMarker = [regex]::Match($registryText, "(?m)^projects\s*:")
    if ($projectsMarker.Success) {
        $contractText = $registryText.Substring(0, $projectsMarker.Index)
    }
    $enumValues = @{}
    $enumMatches = [regex]::Matches($contractText, "(?m)^    (?<name>[a-z][a-z0-9_]*)\s*:\s*\[(?<values>[^\]]*)\]\s*$")
    foreach ($enumMatch in $enumMatches) {
        $enumValues[$enumMatch.Groups["name"].Value] = @(
            $enumMatch.Groups["values"].Value -split "," |
                ForEach-Object { $_.Trim() } |
                Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
        )
    }
    $fieldEnums = [ordered]@{
        lifecycle = "lifecycle"
        knowledge_tier = "knowledge_tier"
        config_source = "config_source"
        config_authority = "config_authority"
        config_write_policy = "config_write_policy"
        agentmemory_status = "capability_status"
        codegraph_status = "capability_status"
        verification_status = "capability_status"
        database_access = "database_access"
        auth_workflow = "auth_workflow"
        browser_session_policy = "browser_session_policy"
    }

    $projectIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $registeredWikiPages = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $frontmatterMirror = [ordered]@{
        project_id = "project_id"
        project_lifecycle = "lifecycle"
        knowledge_tier = "knowledge_tier"
        config_source = "config_source"
        config_authority = "config_authority"
        agentmemory_status = "agentmemory_status"
        codegraph_status = "codegraph_status"
        verification_status = "verification_status"
        last_verified = "last_verified"
    }

    foreach ($project in $registryProjects) {
        foreach ($field in $requiredProjectFields) {
            if (
                -not $project.Contains($field) -or
                [string]::IsNullOrWhiteSpace([string]$project[$field])
            ) {
                $projectLabel = if ($project.Contains("project_id")) { $project["project_id"] } else { "<unknown>" }
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "项目 $projectLabel 缺少必要字段：$field"
            }
        }

        $projectId = if ($project.Contains("project_id")) { [string]$project["project_id"] } else { "" }
        if (-not [string]::IsNullOrWhiteSpace($projectId)) {
            if (-not $projectIds.Add($projectId)) {
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "project_id 重复：$projectId"
            }
        }

        foreach ($enumField in $fieldEnums.Keys) {
            if (-not $project.Contains($enumField)) {
                continue
            }
            $enumName = $fieldEnums[$enumField]
            if (-not $enumValues.ContainsKey($enumName)) {
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "缺少枚举契约：$enumName"
                continue
            }
            $enumValue = Get-ComparableScalar $project[$enumField]
            if ($enumValues[$enumName] -notcontains $enumValue) {
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "项目 $projectId 的 $enumField 值不在枚举内：$enumValue"
            }
        }

        if ($project.Contains("config_source") -and $project["config_source"] -eq "nacos") {
            if (-not $project.Contains("config_authority") -or $project["config_authority"] -ne "remote-current") {
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "Nacos 项目 $projectId 必须使用 config_authority=remote-current"
            }
            if (-not $project.Contains("config_write_policy") -or $project["config_write_policy"] -ne "explicit-user-request-only") {
                Add-Issue $issues "error" "registry" "schema\projects.yaml" "Nacos 项目 $projectId 必须使用 config_write_policy=explicit-user-request-only"
            }
        }

        if ($project.Contains("auth_workflow") -and $project["auth_workflow"] -eq "local-demo-first") {
            foreach ($harnessField in @("test_harness_path", "test_harness_url", "browser_session_policy")) {
                if (
                    -not $project.Contains($harnessField) -or
                    [string]::IsNullOrWhiteSpace([string]$project[$harnessField])
                ) {
                    Add-Issue $issues "error" "registry" "schema\projects.yaml" "项目 $projectId 使用 local-demo-first 但缺少 $harnessField"
                }
            }
        }

        $pathChecks = @(
            [pscustomobject]@{ Field = "repository_path"; PathType = "Container" },
            [pscustomobject]@{ Field = "agents_path"; PathType = "Leaf" },
            [pscustomobject]@{ Field = "agentmemory_path"; PathType = "Container" },
            [pscustomobject]@{ Field = "test_harness_path"; PathType = "Container" }
        )
        foreach ($pathCheck in $pathChecks) {
            if (-not $project.Contains($pathCheck.Field)) {
                continue
            }
            $pathValue = $project[$pathCheck.Field]
            if ($null -eq $pathValue -or [string]::IsNullOrWhiteSpace([string]$pathValue)) {
                continue
            }
            if (-not (Test-Path -LiteralPath ([string]$pathValue) -PathType $pathCheck.PathType)) {
                Add-Issue $issues "error" "registry-path" "schema\projects.yaml" "项目 $projectId 的 $($pathCheck.Field) 不存在：$pathValue"
            }
        }

        if ($project.Contains("wiki_page") -and -not [string]::IsNullOrWhiteSpace([string]$project["wiki_page"])) {
            $wikiRelative = ([string]$project["wiki_page"]).Replace("\", "/")
            $registeredWikiPages.Add($wikiRelative) | Out-Null
            $wikiPath = Join-Path $VaultRoot ([string]$project["wiki_page"])
            if (-not (Test-Path -LiteralPath $wikiPath -PathType Leaf)) {
                Add-Issue $issues "error" "registry-path" $wikiRelative "项目 $projectId 的 wiki_page 不存在"
            }
            else {
                $frontmatter = Get-MarkdownFrontmatter $wikiPath
                foreach ($frontmatterField in $frontmatterMirror.Keys) {
                    $registryField = $frontmatterMirror[$frontmatterField]
                    if (-not $frontmatter.Contains($frontmatterField)) {
                        Add-Issue $issues "error" "registry-mirror" $wikiRelative "缺少 frontmatter 镜像字段：$frontmatterField"
                        continue
                    }
                    if (-not $project.Contains($registryField)) {
                        Add-Issue $issues "error" "registry-mirror" "schema\projects.yaml" "项目 $projectId 缺少镜像来源字段：$registryField"
                        continue
                    }
                    $frontmatterValue = Get-ComparableScalar $frontmatter[$frontmatterField]
                    $registryValue = Get-ComparableScalar $project[$registryField]
                    if ($frontmatterValue -cne $registryValue) {
                        Add-Issue $issues "error" "registry-mirror" $wikiRelative "字段 $frontmatterField 与 Registry 不一致：$frontmatterValue != $registryValue"
                    }
                }
            }
        }
    }

    $projectPagesRoot = Join-Path $VaultRoot "wiki\projects"
    if (Test-Path -LiteralPath $projectPagesRoot -PathType Container) {
        foreach ($projectPage in (Get-ChildItem -LiteralPath $projectPagesRoot -File -Filter "*.md")) {
            if ($projectPage.Name -eq "README.md") {
                continue
            }
            $projectPageRelative = $projectPage.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
            if (-not $registeredWikiPages.Contains($projectPageRelative)) {
                Add-Issue $issues "error" "registry" $projectPageRelative "项目页未登记到 schema/projects.yaml"
            }
        }
    }
}

$markdownFiles = @(
    Get-ChildItem -LiteralPath $VaultRoot -Recurse -File -Filter "*.md" |
        Where-Object {
            $relativePath = $_.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
            $relativePath -notlike "outputs/reports/*"
        }
)
$markdownBasenames = @{}
foreach ($file in $markdownFiles) {
    $relative = $file.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    if (-not $markdownBasenames.ContainsKey($baseName)) {
        $markdownBasenames[$baseName] = [System.Collections.Generic.List[string]]::new()
    }
    $markdownBasenames[$baseName].Add($relative) | Out-Null
}

foreach ($file in $markdownFiles) {
    $relative = $file.FullName.Substring($VaultRoot.Length + 1)
    $text = Get-Content -LiteralPath $file.FullName -Raw
    if (Test-ReplacementChar $file.FullName) {
        Add-Issue $issues "error" "encoding" $relative "文件包含替换字符，疑似乱码"
    }
    if ($text -match "[\x00-\x09\x0B\x0C\x0E-\x1F]") {
        Add-Issue $issues "error" "encoding" $relative "文件包含不可见控制字符"
    }
    if ($text -match "(^|[^r])aw/legacy|(^|[^r])aw/inbox|(^|[^t])ools/|(?<!a)gentMemory") {
        Add-Issue $issues "error" "encoding" $relative "文件包含疑似反引号转义后的退化文本"
    }
    $firstLine = Get-Content -LiteralPath $file.FullName -TotalCount 1
    if ($firstLine -ne "---") {
        Add-Issue $issues "warn" "frontmatter" $relative "Markdown 文件缺少 YAML frontmatter"
    }
}

foreach ($file in $markdownFiles) {
    $relative = $file.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
    if ($relative -like "raw/inbox/*") {
        continue
    }
    $sourceDir = Split-Path -Parent $relative
    $text = Get-Content -LiteralPath $file.FullName -Raw
    $matches = [regex]::Matches($text, "\[\[([^\]]+)\]\]")
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value.Split("|")[0].Split("#")[0].Trim()
        if ([string]::IsNullOrWhiteSpace($target)) {
            continue
        }
        if ($target -match "^[A-Za-z][A-Za-z0-9+.-]*:") {
            continue
        }

        $candidateTexts = [System.Collections.Generic.List[string]]::new()
        $targetExtension = [System.IO.Path]::GetExtension($target)
        if (-not [string]::IsNullOrWhiteSpace($targetExtension)) {
            $candidateTexts.Add($target) | Out-Null
        }
        else {
            $candidateTexts.Add("$target.md") | Out-Null
            $candidateTexts.Add("$target/README.md") | Out-Null
        }

        $resolved = $false
        if ($target -notmatch "[/\\]" -and $markdownBasenames.ContainsKey($target)) {
            $resolved = $true
        }

        foreach ($candidateText in $candidateTexts) {
            if ($resolved) {
                break
            }
            foreach ($base in @("", $sourceDir)) {
                if ($resolved) {
                    break
                }
                $combined = if ([string]::IsNullOrWhiteSpace($base)) {
                    Join-Path $VaultRoot $candidateText
                }
                else {
                    Join-Path (Join-Path $VaultRoot $base) $candidateText
                }
                try {
                    $full = [System.IO.Path]::GetFullPath($combined)
                }
                catch {
                    continue
                }
                if (-not $full.StartsWith($VaultRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
                    continue
                }
                if (Test-Path -LiteralPath $full -PathType Leaf) {
                    $resolved = $true
                    break
                }
            }
        }

        if (-not $resolved) {
            Add-Issue $issues "error" "wikilink" $relative "断链：$($match.Value)"
        }
    }
}

$secretPatterns = @(
    "Authorization:\s*Bearer\s+[A-Za-z0-9._\-]+",
    "sk-[A-Za-z0-9]{20,}",
    "BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY",
    "(?i)(password|passwd|pwd)\s*[:=]\s*['""][^'""]{6,}['""]",
    "(?i)(token|secret|api[_-]?key)\s*[:=]\s*['""][^'""]{12,}['""]"
)
foreach ($file in $markdownFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($pattern in $secretPatterns) {
        if ($text -match $pattern) {
            Add-Issue $issues "warn" "security" ($file.FullName.Substring($VaultRoot.Length + 1)) "命中疑似敏感信息模式：$pattern"
            break
        }
    }
}

$dailyPending = 0
$reviewBacklog = 0
$overdueReviews = 0
$inboxRoot = Join-Path $VaultRoot "raw\inbox"
if (Test-Path -LiteralPath $inboxRoot -PathType Container) {
    $todayDate = (Get-Date).Date
    $inboxMarkdownFiles = @(Get-ChildItem -LiteralPath $inboxRoot -Recurse -File -Filter "*.md")
    foreach ($inboxFile in $inboxMarkdownFiles) {
        $frontmatter = Get-MarkdownFrontmatter $inboxFile.FullName
        $type = if ($frontmatter.Contains("type")) {
            (Get-ComparableScalar $frontmatter["type"]).ToLowerInvariant()
        }
        else {
            ""
        }
        if ($type -in @("directory-index", "inbox-guide")) {
            continue
        }

        $processingStatus = if ($frontmatter.Contains("processing_status")) {
            (Get-ComparableScalar $frontmatter["processing_status"]).ToLowerInvariant()
        }
        elseif ($frontmatter.Contains("status")) {
            (Get-ComparableScalar $frontmatter["status"]).ToLowerInvariant()
        }
        else {
            ""
        }

        $compileDecision = if ($frontmatter.Contains("compile_decision")) {
            (Get-ComparableScalar $frontmatter["compile_decision"]).ToLowerInvariant()
        }
        else {
            ""
        }

        if (
            [string]::IsNullOrWhiteSpace($processingStatus) -or
            $processingStatus -in @("pending", "unreviewed", "new", "inbox") -or
            $compileDecision -eq "unreviewed"
        ) {
            $dailyPending++
        }

        if (
            $processingStatus -notin @("review", "weekly-review") -and
            $compileDecision -ne "weekly-review"
        ) {
            continue
        }

        $reviewBacklog++
        $relativeInboxPath = $inboxFile.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
        $dueFieldPresent = $frontmatter.Contains("due") -or $frontmatter.Contains("review_due")
        $dueDate = Get-FrontmatterDate $frontmatter @("due", "review_due")
        if ($null -ne $dueDate) {
            if ($dueDate -lt $todayDate) {
                $overdueReviews++
                Add-Issue $issues "warn" "review" $relativeInboxPath "复盘 due 已过期：$($dueDate.ToString('yyyy-MM-dd'))"
            }
            continue
        }

        if ($dueFieldPresent) {
            Add-Issue $issues "warn" "review" $relativeInboxPath "复盘 due 必须使用 yyyy-MM-dd"
            continue
        }

        $referenceDate = Get-FrontmatterDate $frontmatter @("last_seen", "updated", "created")
        if ($null -eq $referenceDate) {
            $referenceDate = $inboxFile.LastWriteTime.Date
        }
        $reviewAgeDays = ($todayDate - $referenceDate).Days
        if ($reviewAgeDays -gt 14) {
            $overdueReviews++
            Add-Issue $issues "warn" "review" $relativeInboxPath "复盘已超过 14 天且未设置 due：$reviewAgeDays 天"
        }
    }
}

$cCodexPath = "C:\Users\CxM\Documents\Codex"
if (Test-Path -LiteralPath $cCodexPath) {
    $item = Get-Item -LiteralPath $cCodexPath -Force
    $isExpectedJunction = $false
    if ($item.LinkType -eq "Junction") {
        $isExpectedJunction = (@($item.Target) -contains "D:\CodeX\conversations")
    }
    if (-not $isExpectedJunction) {
        Add-Issue $issues "warn" "c-drive" $cCodexPath "Codex C 盘入口不是预期 junction"
    }
}

$errorCount = @($issues | Where-Object Severity -eq "error").Count
$warnCount = @($issues | Where-Object Severity -eq "warn").Count
$infoCount = @($issues | Where-Object Severity -eq "info").Count
$status = if ($errorCount -eq 0) { "pass" } else { "fail" }
$checkedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$issueLines = if ($issues.Count -eq 0) {
    "- 无"
}
else {
    ($issues | ForEach-Object {
        "- [$($_.Severity)] $($_.Area) - $($_.Path)：$($_.Message)"
    }) -join "`n"
}

$today = Get-Date -Format "yyyy-MM-dd"
$reportParts = @(
    "---",
    "type: health-report",
    "status: active",
    "created: $today",
    "updated: $today",
    "source_refs:",
    "  - tools/Test-CxMVault.ps1",
    "confidence: EXTRACTED",
    "tags:",
    "  - health-check",
    "  - cxmvault",
    "---",
    "",
    "# CxMVault 健康检查报告",
    "",
    "## 本次结果",
    "",
    "- 检查时间：$checkedAt",
    "- 状态：$status",
    "- error：$errorCount",
    "- warn：$warnCount",
    "- info：$infoCount",
    "- Markdown 文件数：$($markdownFiles.Count)",
    "- Obsidian 已安装插件数：$($installedPlugins.Count)",
    "- Obsidian 已启用插件数：$($enabledPlugins.Count)",
    "- Registry 项目数：$registeredProjects",
    "- Daily pending：$dailyPending",
    "- Review backlog：$reviewBacklog",
    "- Overdue reviews：$overdueReviews",
    "",
    "## 问题列表",
    "",
    $issueLines,
    "",
    "## 检查范围",
    "",
    "- Karpathy LLM Wiki 核心目录和入口文件",
    "- 顶层目录、inbox 子目录和模板目录 README",
    "- Obsidian 主题、插件目录、启用列表和旧会话状态",
    "- Project Registry 必要字段、枚举、路径、Nacos 策略、项目页登记和 frontmatter 镜像",
    "- Daily pending、Review backlog 与超期复盘",
    "- 旧 CodeXKnowledge 与 agentMemory 桥接入口",
    "- Markdown frontmatter、H1、替换字符乱码和不可见控制字符",
    "- Obsidian wikilink 断链（raw/inbox 原始剪藏和 outputs/reports 生成报告除外）",
    "- 常见敏感信息模式",
    "- C 盘 Codex junction 状态",
    "",
    "## 运行命令",
    "",
    "~~~powershell",
    "& 'E:\AIWorkspace\CxMVault\tools\Test-CxMVault.ps1'",
    "~~~"
)
$report = $reportParts -join "`n"

$reportWritten = $false
if (-not $NoWrite) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ReportPath) | Out-Null
    Set-Content -LiteralPath $ReportPath -Value $report -Encoding UTF8
    $reportWritten = $true
}

[pscustomobject]@{
    Status = $status
    Errors = $errorCount
    Warnings = $warnCount
    Info = $infoCount
    MarkdownFiles = $markdownFiles.Count
    Plugins = $installedPlugins.Count
    InstalledPlugins = $installedPlugins.Count
    EnabledPlugins = $enabledPlugins.Count
    RegisteredProjects = $registeredProjects
    DailyPending = $dailyPending
    ReviewBacklog = $reviewBacklog
    OverdueReviews = $overdueReviews
    ReportPath = $ReportPath
    ReportWritten = $reportWritten
}

