param(
    [string]$VaultRoot = "E:\AIWorkspace\CxMVault",
    [string]$SourceVault = "E:\CodeXData\CodeXKnowledge",
    [string]$SourceMemory = "E:\CodeXData\agentMemory"
)

$ErrorActionPreference = "Stop"

function Ensure-Dir {
    param([string]$Path)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Write-Utf8 {
    param(
        [string]$Path,
        [string]$Value
    )
    if ([System.IO.Path]::GetExtension($Path) -eq ".md" -and (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return
    }
    Ensure-Dir (Split-Path -Parent $Path)
    Set-Content -LiteralPath $Path -Value $Value -Encoding UTF8
}

function Copy-DirFresh {
    param(
        [string]$Source,
        [string]$Destination
    )
    if (Test-Path -LiteralPath $Destination) {
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }
    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
}

function Get-RelativePath {
    param(
        [string]$Root,
        [string]$Path
    )
    $rootFull = [System.IO.Path]::GetFullPath($Root).TrimEnd("\") + "\"
    $pathFull = [System.IO.Path]::GetFullPath($Path)
    return $pathFull.Substring($rootFull.Length)
}

function Convert-ToWikiPath {
    param([string]$Path)
    return $Path.Replace("\", "/")
}

if (-not (Test-Path -LiteralPath $VaultRoot -PathType Container)) {
    Ensure-Dir $VaultRoot
}
if (-not (Test-Path -LiteralPath $SourceVault -PathType Container)) {
    throw "Source vault not found: $SourceVault"
}

$today = Get-Date -Format "yyyy-MM-dd"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$dirs = @(
    "raw",
    "raw\legacy",
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
    "schema",
    "schema\adapters",
    "logs",
    "outputs",
    "outputs\reports",
    "outputs\graphs",
    "outputs\exports",
    "tools"
)
foreach ($dir in $dirs) {
    Ensure-Dir (Join-Path $VaultRoot $dir)
}

$obsidianRoot = Join-Path $VaultRoot ".obsidian"
$sourceObsidian = Join-Path $SourceVault ".obsidian"
Ensure-Dir $obsidianRoot

$configFiles = @(
    "app.json",
    "appearance.json",
    "core-plugins.json",
    "community-plugins.json",
    "graph.json",
    "backlink.json",
    "webviewer.json"
)
foreach ($file in $configFiles) {
    $src = Join-Path $sourceObsidian $file
    if (Test-Path -LiteralPath $src -PathType Leaf) {
        Copy-Item -LiteralPath $src -Destination (Join-Path $obsidianRoot $file) -Force
    }
}

foreach ($dir in @("icons", "themes")) {
    $src = Join-Path $sourceObsidian $dir
    if (Test-Path -LiteralPath $src -PathType Container) {
        Copy-DirFresh $src (Join-Path $obsidianRoot $dir)
    }
}

$pluginIds = @(
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
$pluginsRoot = Join-Path $obsidianRoot "plugins"
Ensure-Dir $pluginsRoot
foreach ($pluginId in $pluginIds) {
    $src = Join-Path (Join-Path $sourceObsidian "plugins") $pluginId
    if (Test-Path -LiteralPath $src -PathType Container) {
        Copy-DirFresh $src (Join-Path $pluginsRoot $pluginId)
    }
}

$recentFilesData = Join-Path $pluginsRoot "recent-files-obsidian\data.json"
if (Test-Path -LiteralPath $recentFilesData -PathType Leaf) {
    Write-Utf8 $recentFilesData "{`n  `"recentFiles`": []`n}"
}

$claudianData = Join-Path $pluginsRoot "realclaudian\data.json"
if (Test-Path -LiteralPath $claudianData -PathType Leaf) {
    Write-Utf8 $claudianData "{`n  `"tabManagerState`": {`n    `"openTabs`": [],`n    `"activeTabId`": null`n  }`n}"
}

$workspace = @"
{
  "main": {
    "id": "cxmvault-main",
    "type": "split",
    "children": [
      {
        "id": "cxmvault-home-leaf",
        "type": "leaf",
        "state": {
          "type": "markdown",
          "state": {
            "file": "wiki/overview.md",
            "mode": "source",
            "source": false
          }
        }
      }
    ],
    "direction": "vertical"
  },
  "left": {
    "id": "cxmvault-left",
    "type": "split",
    "children": [],
    "direction": "horizontal",
    "width": 300
  },
  "right": {
    "id": "cxmvault-right",
    "type": "split",
    "children": [],
    "direction": "horizontal",
    "width": 300,
    "collapsed": true
  },
  "active": "cxmvault-home-leaf",
  "lastOpenFiles": [
    "wiki/overview.md",
    "wiki/index.md",
    "schema/AGENTS.md"
  ]
}
"@
Write-Utf8 (Join-Path $obsidianRoot "workspace.json") $workspace
Write-Utf8 (Join-Path $obsidianRoot "workspaces.json") "{`n  `"workspaces`": {}`n}"

$sourceMarkdown = @(Get-ChildItem -LiteralPath $SourceVault -Recurse -File -Filter '*.md' -ErrorAction SilentlyContinue)
$sourceMarkdownNoTmp = @($sourceMarkdown | Where-Object { $_.FullName -notmatch "\\\.tmp\\" })
$projectRoot = Join-Path $SourceVault "10-projects"
$projects = @()
if (Test-Path -LiteralPath $projectRoot -PathType Container) {
    $projects = @(Get-ChildItem -LiteralPath $projectRoot -Directory | Sort-Object Name)
}
$globalFolders = @("20-runbooks", "30-decisions", "40-error-cases", "50-code-anchors", "70-compiled-wiki", "80-templates")

$legacyProjectLines = foreach ($project in $projects) {
    $md = @(Get-ChildItem -LiteralPath $project.FullName -Recurse -File -Filter '*.md' -ErrorAction SilentlyContinue)
    $readme = @($md | Where-Object { $_.Name -eq "README.md" })
    $valuable = @($md | Where-Object { $_.Name -ne "README.md" -and $_.FullName -notmatch "\\schema\\AGENTS\.md$" })
    "- {0}：Markdown {1}，README {2}，非 README 笔记 {3}，旧路径 {4}" -f $project.Name, $md.Count, $readme.Count, $valuable.Count, $project.FullName
}

$globalLines = foreach ($folder in $globalFolders) {
    $path = Join-Path $SourceVault $folder
    if (Test-Path -LiteralPath $path -PathType Container) {
        $folderMarkdown = @(Get-ChildItem -LiteralPath $path -Recurse -File -Filter '*.md')
        "- {0}：{1} 个 Markdown" -f $folder, $folderMarkdown.Count
    }
}

$pluginManifestLines = foreach ($pluginId in $pluginIds) {
    $manifest = Join-Path (Join-Path $pluginsRoot $pluginId) "manifest.json"
    if (Test-Path -LiteralPath $manifest -PathType Leaf) {
        $m = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json
        "- {0} ({1})：{2}" -f $m.name, $pluginId, $m.version
    }
}

$legacyReport = @"
---
type: legacy-source-index
status: active
created: $today
updated: $today
source_refs:
  - E:\CodeXData\CodeXKnowledge
confidence: EXTRACTED
tags:
  - legacy
  - codexknowledge
  - migration
---

# CodeXKnowledge 旧库来源索引

## 结论

旧库 `E:\CodeXData\CodeXKnowledge` 保持原样，作为 `CxMVault` 的 legacy source。新库只编译长期有用的项目经验、runbook、decision、error-case 和 code-anchor，不把旧 `.tmp`、旧 Obsidian 会话状态和旧 agent 私有状态作为新 wiki 正文。

## 盘点结果

- 盘点时间：$timestamp
- Markdown 总数：$($sourceMarkdown.Count)
- 排除 `.tmp` 后 Markdown：$($sourceMarkdownNoTmp.Count)
- 项目数：$($projects.Count)
- 旧库路径：`$SourceVault`

## 项目来源

$($legacyProjectLines -join "`n")

## 全局知识来源

$($globalLines -join "`n")

## 迁移规则

- `raw/legacy/codexknowledge/` 只保存来源索引和迁移说明，不直接复制旧库全文
- 旧项目的可复用经验编译到 `wiki/projects/<项目名>/`
- 跨项目流程、决策和错误案例编译到 `wiki/operations/`
- 旧库 `.tmp/` 仅作为历史备份提示，不进入新 wiki 查询主路径
- 旧库继续可读，直到新库覆盖主要项目记忆入口
"@
Write-Utf8 (Join-Path $VaultRoot "raw\legacy\codexknowledge\index.md") $legacyReport

$memoryProjects = @()
if (Test-Path -LiteralPath $SourceMemory -PathType Container) {
    $memoryProjects = @(Get-ChildItem -LiteralPath $SourceMemory -Directory | Where-Object { $_.Name -ne ".tmp" } | Sort-Object Name)
}
$memoryLines = foreach ($project in $memoryProjects) {
    $files = @(Get-ChildItem -LiteralPath $project.FullName -Recurse -File -ErrorAction SilentlyContinue)
    "- {0}：{1} 个记忆文件，旧路径 {2}" -f $project.Name, $files.Count, $project.FullName
}

$memoryBridge = @"
---
type: memory-bridge
status: active
created: $today
updated: $today
source_refs:
  - E:\CodeXData\agentMemory
confidence: EXTRACTED
tags:
  - legacy
  - agentmemory
  - migration
---

# agentMemory 旧项目记忆桥接

## 结论

`E:\CodeXData\agentMemory` 不迁移、不删除、不改写。`CxMVault` 通过本索引提示后续 agent：处理旧项目时仍需读取对应项目的原 agentMemory，避免因为新 vault 初始化而丢失已沉淀的排错路径和执行偏好。

## 项目记忆入口

$($memoryLines -join "`n")

## 使用规则

- 处理 `E:\CodeXData` 下旧项目任务时，先查新库 `wiki/projects/<项目名>/`，再查对应旧 `agentMemory/<项目名>`
- 若旧 memory 中的经验仍有效，应在完成任务后择要编译为 `CxMVault` 的 wiki 页面
- 不写入密钥、Token、密码、私钥、测试账号或完整敏感请求体
- `.tmp` 目录只作为历史系统数据，不作为常规检索入口
"@
Write-Utf8 (Join-Path $VaultRoot "raw\legacy\agentmemory-index\index.md") $memoryBridge

$rootReadme = @"
---
type: vault-home
status: active
created: $today
updated: $today
source_refs:
  - schema/AGENTS.md
confidence: EXTRACTED
tags:
  - index
  - cxmvault
  - llm-wiki
---

# CxMVault

`CxMVault` 是面向个人和项目长期复用的 Karpathy 式 LLM Wiki。原始资料进入 `raw/`，稳定知识由 agent 编译到 `wiki/`，维护规则写在 `schema/`，所有重要维护动作追加到 `logs/`。

## 快速入口

- [[wiki/overview|总览]]
- [[wiki/index|Wiki 索引]]
- [[wiki/log|维护日志]]
- [[schema/AGENTS|中立 Agent 契约]]
- [[raw/legacy/codexknowledge/index|CodeXKnowledge 旧库来源索引]]
- [[raw/legacy/agentmemory-index/index|agentMemory 旧项目记忆桥接]]

## 当前边界

- 第一阶段同时覆盖个人知识和项目经验
- 旧 `CodeXKnowledge` 与 `agentMemory` 保持原样
- 新库只编译长期有用、可追溯、可验证的知识
- Obsidian 使用体验从旧库迁移，但不继承旧 workspace/recent 会话状态
"@
Write-Utf8 (Join-Path $VaultRoot "README.md") $rootReadme

$overview = @"
---
type: overview
status: active
created: $today
updated: $today
source_refs:
  - raw/legacy/codexknowledge/index.md
  - raw/legacy/agentmemory-index/index.md
confidence: EXTRACTED
tags:
  - overview
  - cxmvault
  - llm-wiki
---

# CxMVault 总览

## 定位

`CxMVault` 是统一个人知识库，不绑定单一 agent。它服务两类使用者：

- 人：用 Obsidian 浏览、复盘、发现关联
- Agent：用稳定目录、索引、frontmatter 和维护契约读取、编译、验证知识

## Karpathy 分层

- `raw/`：原始资料和 legacy source，不直接当作最终结论
- `wiki/`：LLM 编译后的结构化知识
- `schema/`：跨 agent 维护契约
- `logs/`：追加式维护轨迹
- `outputs/`：报告、图谱和导出物
- `tools/`：健康检查和迁移辅助脚本

## 旧库关系

- `E:\CodeXData\CodeXKnowledge`：旧 Obsidian 项目知识库，作为 legacy source
- `E:\CodeXData\agentMemory`：旧项目机器记忆，作为 bridge source
- 旧库不被删除、不被搬空、不被静默覆盖

## 当前优先级

1. 保持旧项目经验可检索，避免重复犯错
2. 建立清晰的个人 + 项目知识结构
3. 把有长期价值的旧知识逐步编译进新 wiki
4. 用 lint 和来源追溯压住知识漂移
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\overview.md") $overview

$wikiIndex = @"
---
type: wiki-index
status: active
created: $today
updated: $today
source_refs:
  - wiki/overview.md
confidence: EXTRACTED
tags:
  - index
  - wiki
---

# Wiki 索引

## 核心页面

- [[overview|CxMVault 总览]]
- [[log|维护日志]]

## 项目

- [[projects/matdao_api|matdao_api]]
- [[projects/SteelTechnologyNode_api|SteelTechnologyNode_api]]
- [[projects/MyExcel|MyExcel]]
- 其他旧项目先通过 [[../raw/legacy/agentmemory-index/index|agentMemory 旧项目记忆桥接]] 和 [[../raw/legacy/codexknowledge/index|CodeXKnowledge 旧库来源索引]] 进入

## 操作知识

- [[operations/旧库迁移策略|旧库迁移策略]]
- [[operations/Obsidian配置迁移|Obsidian 配置迁移]]
- [[operations/知识维护闭环|知识维护闭环]]

## 个人知识

- `wiki/personal/`：个人长期主题
- `wiki/domains/`：领域知识
- `wiki/concepts/`：跨领域概念页
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\index.md") $wikiIndex

$wikiLog = @"
---
type: maintenance-log
status: active
created: $today
updated: $today
source_refs:
  - tools/Initialize-CxMVault.ps1
confidence: EXTRACTED
tags:
  - log
  - maintenance
---

# 维护日志

## [$today] initialize | CxMVault 初始化

- 创建 Karpathy LLM Wiki 核心目录：`raw/`、`wiki/`、`schema/`、`logs/`、`outputs/`、`tools/`
- 从旧 `CodeXKnowledge` 白名单迁移 Obsidian 插件、主题和配置
- 重置旧 workspace、recent files、Claudian 会话状态，避免旧 vault 页面污染新库
- 生成旧 `CodeXKnowledge` 来源索引
- 生成 `agentMemory` 旧项目记忆桥接
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\log.md") $wikiLog

$schema = @"
---
type: agent-contract
status: active
created: $today
updated: $today
source_refs:
  - README.md
  - raw/legacy/codexknowledge/index.md
  - raw/legacy/agentmemory-index/index.md
confidence: EXTRACTED
tags:
  - agents
  - schema
  - llm-wiki
---

# CxMVault Agent 契约

## 目标

维护 `E:\AIWorkspace\CxMVault` 这个可持续进化的个人知识库。所有 agent 都应把它视为普通文件夹 + Markdown wiki，而不是绑定某个供应商的专有记忆系统。

## 目录职责

- `raw/`：原始资料、导入资料和 legacy source。agent 可以读取，不应随意改写已有来源
- `wiki/`：编译后的知识页。agent 可以创建和更新，但必须保持来源可追溯
- `schema/`：维护规则和跨 agent 适配入口。修改前先确认影响范围
- `logs/`：追加式维护日志。重大 ingest、query、lint、迁移都要记录
- `outputs/`：报告、图谱、导出物
- `tools/`：验证和迁移脚本

## 工作流

### ingest

1. 新资料先放入 `raw/inbox/` 或对应 `raw/<domain>/`
2. 读取 `wiki/index.md` 判断是否已有相关页面
3. 编译或更新 `wiki/` 页面
4. 更新 `wiki/index.md`
5. 向 `wiki/log.md` 追加记录

### query

1. 先读 `wiki/index.md`
2. 再读目标页面和必要 raw source
3. 回答时说明来源和置信度
4. 有长期价值的回答沉淀回 `wiki/`

### lint

检查断链、孤立页、替换字符乱码、无来源断言、重复主题、敏感信息风险、旧路径误写入和过期结论。

## 页面契约

每个 wiki 页面默认使用 frontmatter：

```yaml
---
type: page-type
status: draft | active | deprecated
created: YYYY-MM-DD
updated: YYYY-MM-DD
source_refs:
  - raw/path-or-external-source
confidence: EXTRACTED | INFERRED | AMBIGUOUS | UNVERIFIED
tags:
  - tag
---
```

## 旧库读取规则

- 旧 `CodeXKnowledge` 是 legacy source：`E:\CodeXData\CodeXKnowledge`
- 旧 `agentMemory` 是项目经验桥接源：`E:\CodeXData\agentMemory`
- 处理旧项目时，先看新库 `wiki/projects/<项目名>.md`；不够时再查旧库索引和对应 agentMemory
- 不删除、不搬空、不静默覆盖旧库

## 安全边界

- 不记录密钥、Token、密码、私钥、Cookie、Authorization、测试账号或完整敏感请求体
- 对疑似敏感信息只报告，不写入 wiki 正文
- Obsidian `.obsidian/workspace.json`、recent files、agent 会话状态属于 UI 状态，不作为知识来源
"@
Write-Utf8 (Join-Path $VaultRoot "schema\AGENTS.md") $schema

$adapterClaude = @"
# Claude Adapter

Read `schema/AGENTS.md` first. This file is only a thin adapter for Claude-style agents; the source of truth is the neutral CxMVault agent contract.

Vault root: `E:\AIWorkspace\CxMVault`
"@
Write-Utf8 (Join-Path $VaultRoot "schema\adapters\CLAUDE.md") $adapterClaude

$adapterHermes = @"
# Hermes Adapter

Read `schema/AGENTS.md` first. This file is only a thin adapter for Hermes-style agents; the source of truth is the neutral CxMVault agent contract.

Vault root: `E:\AIWorkspace\CxMVault`
"@
Write-Utf8 (Join-Path $VaultRoot "schema\adapters\HERMES.md") $adapterHermes

$opsMigration = @"
---
type: operation
status: active
created: $today
updated: $today
source_refs:
  - raw/legacy/codexknowledge/index.md
  - raw/legacy/agentmemory-index/index.md
confidence: EXTRACTED
tags:
  - migration
  - legacy
  - runbook
---

# 旧库迁移策略

## 结论

旧 `CodeXKnowledge` 和 `agentMemory` 不直接搬空，也不把旧结构完整复制成新正文。`CxMVault` 采用“legacy source 可追溯 + 精选编译迁移”的方式，优先迁移会阻止重复犯错的项目经验。

## 编译优先级

1. 项目启动和联调路径
2. 已验证的错误根因和修复步骤
3. 固定流程和 runbook
4. 长期设计取舍
5. 代码锚点和项目规则

## 不进入正文的内容

- 旧 `.tmp/` 备份
- Obsidian workspace 和 recent files
- agent 私有会话状态
- 空 README 占位页
- 无复用价值的流水日志
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\operations\旧库迁移策略.md") $opsMigration

$opsObsidian = @"
---
type: operation
status: active
created: $today
updated: $today
source_refs:
  - E:\CodeXData\CodeXKnowledge\.obsidian
confidence: EXTRACTED
tags:
  - obsidian
  - configuration
  - migration
---

# Obsidian 配置迁移

## 已迁移

- 主题：ITS Theme、Minimal
- 当前主题：ITS Theme
- 社区插件：
$($pluginManifestLines -join "`n")
- 核心配置：`app.json`、`appearance.json`、`core-plugins.json`、`community-plugins.json`、`graph.json`、`backlink.json`、`webviewer.json`
- 图标目录：`.obsidian/icons`

## 已重置

- `workspace.json`：只打开 `wiki/overview.md`
- `workspaces.json`：清空旧 workspace
- `recent-files-obsidian/data.json`：清空旧最近文件
- `realclaudian/data.json`：清空旧 Claudian 标签页状态

## 原则

Obsidian 使用体验可以继承，旧 vault 的页面状态不继承。
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\operations\Obsidian配置迁移.md") $opsObsidian

$opsLoop = @"
---
type: operation
status: active
created: $today
updated: $today
source_refs:
  - schema/AGENTS.md
confidence: EXTRACTED
tags:
  - maintenance
  - llm-wiki
  - runbook
---

# 知识维护闭环

## ingest

资料进入 `raw/`，agent 读取后更新 `wiki/`，并追加 `wiki/log.md`。

## query

问题优先从 `wiki/index.md` 导航，再读相关页面。若回答形成长期结论，应沉淀为 wiki 页面。

## lint

定期运行 `tools/Test-CxMVault.ps1`，检查结构、Obsidian 配置、旧库桥接、Markdown 质量和敏感信息风险。
"@
Write-Utf8 (Join-Path $VaultRoot "wiki\operations\知识维护闭环.md") $opsLoop

foreach ($projectName in @("matdao_api", "SteelTechnologyNode_api", "MyExcel")) {
    $sourceProjectPath = Join-Path $SourceVault "10-projects\$projectName"
    $memoryProjectPath = Join-Path $SourceMemory $projectName
    $projectPage = @"
---
type: project-bridge
status: active
created: $today
updated: $today
source_refs:
  - $sourceProjectPath
  - $memoryProjectPath
confidence: EXTRACTED
tags:
  - project
  - legacy-bridge
  - $projectName
---

# $projectName

## 结论

本页是 `$projectName` 的新库入口。迁移初期先桥接旧 `CodeXKnowledge` 与旧 `agentMemory`，后续再把高价值内容逐步编译成本页下游专题。

## 旧来源

- 旧项目知识库：`$sourceProjectPath`
- 旧 agentMemory：`$memoryProjectPath`

## 使用方式

1. 新任务先读本页
2. 再读 [[../../raw/legacy/codexknowledge/index|CodeXKnowledge 旧库来源索引]]
3. 项目细节不足时读取旧路径中的项目 wiki 和 agentMemory
4. 已验证且长期有用的内容应回填到 `CxMVault/wiki/projects/` 或 `CxMVault/wiki/operations/`
"@
    Write-Utf8 (Join-Path $VaultRoot "wiki\projects\$projectName.md") $projectPage
}

$readmeDirs = @(
    "raw\inbox",
    "raw\personal",
    "raw\projects",
    "wiki\personal",
    "wiki\domains",
    "wiki\concepts",
    "outputs",
    "logs"
)
foreach ($dir in $readmeDirs) {
    $title = $dir.Replace("\", "/")
    $content = @"
---
type: directory-index
status: active
created: $today
updated: $today
source_refs:
  - schema/AGENTS.md
confidence: EXTRACTED
tags:
  - index
---

# $title

本目录按 `schema/AGENTS.md` 维护。新增内容应保持来源可追溯、命名清晰、可被 `wiki/index.md` 或上级索引抵达。
"@
    Write-Utf8 (Join-Path $VaultRoot "$dir\README.md") $content
}

[pscustomobject]@{
    VaultRoot = $VaultRoot
    SourceVault = $SourceVault
    SourceMemory = $SourceMemory
    Projects = $projects.Count
    SourceMarkdown = $sourceMarkdown.Count
    SourceMarkdownNoTmp = $sourceMarkdownNoTmp.Count
    MemoryProjects = $memoryProjects.Count
    Plugins = $pluginIds.Count
}


