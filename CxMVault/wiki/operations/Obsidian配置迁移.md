---
type: operation
status: active
created: 2026-07-02
updated: 2026-07-02
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
  - Better Export PDF (`better-export-pdf`)：2.0.2
  - Dataview (`dataview`)：0.5.68
  - Link Favicons (`link-favicon`)：1.8.5
  - Excalidraw (`obsidian-excalidraw-plugin`)：2.25.0
  - Export Image plugin (`obsidian-export-image`)：2.4.4
  - Iconize (`obsidian-icon-folder`)：2.14.7
  - Claudian (`realclaudian`)：2.0.27
  - Recent Files (`recent-files-obsidian`)：1.7.9
  - Templater (`templater-obsidian`)：2.20.6
- 核心配置：`app.json`、`appearance.json`、`core-plugins.json`、`community-plugins.json`、`graph.json`、`backlink.json`、`webviewer.json`
- 图标目录：`.obsidian/icons`
- Daily Notes 配置：默认写入 `reviews/daily/`
- Templates 配置：默认读取 `templates/`
- Obsidian 忽略规则：隐藏 `.claude/`、`.claudian/`、`.qmd/`、`.skills-data/`、构建目录、缓存目录和临时目录

## 已重置

- `workspace.json`：默认打开 `00-开始使用.md`
- `workspaces.json`：清空旧 workspace
- `recent-files-obsidian/data.json`：清空旧最近文件
- `realclaudian/data.json`：清空旧 Claudian 标签页状态

## 原则

Obsidian 使用体验可以继承，旧 vault 的页面状态不继承。
