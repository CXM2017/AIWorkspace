---
type: vault-home
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - 00-开始使用.md
  - schema/AGENTS.md
confidence: EXTRACTED
tags:
  - index
  - cxmvault
  - llm-wiki
---

# CxMVault

CxMVault 是一个面向“个人 + 项目”的持续进化知识库。它不是单纯资料仓库，而是一个闭环系统：采集资料、每日消化、编译成 wiki、每周复盘、定期健康检查。

## 先从这里开始

- [[00-开始使用|00-开始使用]]
- [[wiki/overview|知识库总览]]
- [[wiki/index|Wiki 索引]]
- [[wiki/operations/采集消化复盘SOP|采集消化复盘 SOP]]
- [[schema/AGENTS|Agent 契约]]

## 每天怎么用

1. 网页、文章、截图、文件、临时想法先放入 `raw/inbox/` 对应子目录
2. 每天让 agent 按 [[wiki/operations/采集消化复盘SOP|SOP]] 消化 inbox
3. 稳定结论进入 `wiki/`
4. 每周做一次 `reviews/weekly/` 复盘
5. 每月检查结构、断链、过期结论和旧库迁移进度

## 当前底层结构

- `raw/`：原始资料和收件箱
- `wiki/`：编译后的长期知识
- `reviews/`：每日、每周、每月复盘
- `templates/`：采集、消化、复盘模板
- `schema/`：跨 agent 维护契约
- `logs/`：系统维护日志
- `outputs/`：报告、图谱、导出物
- `tools/`：检查和迁移脚本

