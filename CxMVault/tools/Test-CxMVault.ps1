param(
    [string]$VaultRoot = "E:\AIWorkspace\CxMVault",
    [string]$SourceVault = "E:\CodeXData\CodeXKnowledge",
    [string]$SourceMemory = "E:\CodeXData\agentMemory",
    [string]$ReportPath = ""
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
    "tools\Initialize-CxMVault.ps1",
    "tools\Test-CxMVault.ps1"
)
foreach ($file in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $VaultRoot $file) -PathType Leaf)) {
        Add-Issue $issues "error" "structure" $file "缺少核心文件"
    }
}

$expectedPlugins = @(
    "better-export-pdf",
    "dataview",
    "link-favicon",
    "obsidian-excalidraw-plugin",
    "obsidian-export-image",
    "obsidian-icon-folder",
    "realclaudian",
    "recent-files-obsidian",
    "templater-obsidian"
)
$pluginsRoot = Join-Path $VaultRoot ".obsidian\plugins"
foreach ($plugin in $expectedPlugins) {
    $manifest = Join-Path (Join-Path $pluginsRoot $plugin) "manifest.json"
    if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
        Add-Issue $issues "error" "obsidian" ".obsidian\plugins\$plugin" "缺少插件 manifest"
    }
}

$communityPath = Join-Path $VaultRoot ".obsidian\community-plugins.json"
if (Test-Path -LiteralPath $communityPath -PathType Leaf) {
    $enabledPlugins = @(Get-Content -LiteralPath $communityPath -Raw | ConvertFrom-Json)
    foreach ($plugin in $expectedPlugins) {
        if ($enabledPlugins -notcontains $plugin) {
            Add-Issue $issues "error" "obsidian" ".obsidian\community-plugins.json" "插件未启用：$plugin"
        }
    }
}
else {
    Add-Issue $issues "error" "obsidian" ".obsidian\community-plugins.json" "缺少社区插件启用列表"
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

$markdownFiles = @(
    Get-ChildItem -LiteralPath $VaultRoot -Recurse -File -Filter "*.md" |
        Where-Object {
            $relativePath = $_.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
            $relativePath -notlike "outputs/reports/*"
        }
)
$markdownRelativePaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$markdownBasenames = @{}
foreach ($file in $markdownFiles) {
    $relative = $file.FullName.Substring($VaultRoot.Length + 1).Replace("\", "/")
    $markdownRelativePaths.Add($relative) | Out-Null
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
        if ($target.EndsWith(".md", [System.StringComparison]::OrdinalIgnoreCase)) {
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
                $candidateRelative = $full.Substring($VaultRoot.Length + 1).Replace("\", "/")
                if ($markdownRelativePaths.Contains($candidateRelative)) {
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
    "- Obsidian 插件数：$($expectedPlugins.Count)",
    "",
    "## 问题列表",
    "",
    $issueLines,
    "",
    "## 检查范围",
    "",
    "- Karpathy LLM Wiki 核心目录和入口文件",
    "- 顶层目录、inbox 子目录和模板目录 README",
    "- Obsidian 主题、插件、启用列表和旧会话状态",
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

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ReportPath) | Out-Null
Set-Content -LiteralPath $ReportPath -Value $report -Encoding UTF8

[pscustomobject]@{
    Status = $status
    Errors = $errorCount
    Warnings = $warnCount
    Info = $infoCount
    MarkdownFiles = $markdownFiles.Count
    Plugins = $expectedPlugins.Count
    ReportPath = $ReportPath
}

