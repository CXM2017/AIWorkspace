---
type: operation
status: active
created: 2026-07-02
updated: 2026-09-08
source_refs:
  - E:\CodeXData\CodeXKnowledge\.obsidian
  - E:\AIWorkspace\CxMVault\.obsidian\community-plugins.json
  - E:\AIWorkspace\CxMVault\.obsidian\app.json
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
  - Better Export PDF (`better-export-pdf`)：2.0.2
  - Dataview (`dataview`)：0.5.68
  - Link Favicons (`link-favicon`)：1.8.5
  - Excalidraw (`obsidian-excalidraw-plugin`)：2.25.0
  - Export Image plugin (`obsidian-export-image`)：2.4.4
  - Iconize (`obsidian-icon-folder`)：2.14.7
  - Claudian (`realclaudian`)：2.0.27
  - Recent Files (`recent-files-obsidian`)：1.7.9
  - Templater (`templater-obsidian`)：2.20.6
  - Obsidian Git (`obsidian-git`)：2.38.5
- 核心配置：`app.json`、`appearance.json`、`core-plugins.json`、`community-plugins.json`、`graph.json`、`backlink.json`、`webviewer.json`
- 图标目录：`.obsidian/icons`
- Daily Notes 配置：默认写入 `reviews/daily/`
- Templates 配置：默认读取 `templates/`
- Obsidian 忽略规则：隐藏 `.claude/`、`.claudian/`、`.qmd/`、`.skills-data/`、`agentMemory/`、`.git/`、依赖目录、构建目录、缓存目录、日志和临时目录

2026-09-08 本地复核：10 个社区插件均已安装并启用；当前 CSS 主题仍为 ITS Theme，底层主题为 moonstone。版本清单来自本 Vault 的 `manifest.json`，不是在线更新声明。

## 迁移时已重置

- `workspace.json`：迁移基线默认打开 `00-开始使用.md`
- `workspaces.json`：迁移时清空旧 workspace
- `recent-files-obsidian/data.json`：迁移时清空旧最近文件
- `realclaudian/data.json`：迁移时清空旧 Claudian 标签页状态

## 原则

Obsidian 使用体验可以继承，旧 vault 的页面状态不继承；后续的 workspace、recent files 与插件标签页属于用户当前 UI 状态，不由知识维护任务重置或归档。
