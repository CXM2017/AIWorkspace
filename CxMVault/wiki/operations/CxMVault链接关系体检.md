---
type: operation
status: active
created: 2026-07-07
updated: 2026-08-13
source_refs:
  - wiki/index.md
  - wiki/知识库图谱入口.md
  - outputs/reports/CxMVault-health-report.md
  - outputs/automation/cxmvault-maintenance/run-result.json
confidence: EXTRACTED
tags:
  - graph
  - backlinks
  - maintenance
  - cxmvault
---

# CxMVault 链接关系体检

## 结论

截至 2026-08-13，本次扫描 237 个 Markdown 文件。默认图谱过滤后保留 `wiki/` 下 21 个长期知识页；补齐入口连接和维护规则后，50 条可见链接引用已将全部长期页接入主干。当前链接结构总体可用：入口页、图谱页、项目桥接页和日常闭环页面形成清晰主干。

需要补的不是所有页面互相乱连，而是三类链接：

- 入口链接：新长期页必须从 [[../index|Wiki 索引]] 和 [[../知识库图谱入口|知识库图谱入口]] 可达
- 主题链接：领域页之间只在有真实语义关系时互链
- 工作流链接：自动化、采集、消化、复盘页面之间保持闭环

## 本次已补链接

- 将 [[../domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]] 加入 `wiki/index.md` 和 [[../知识库图谱入口|知识库图谱入口]]
- 将本页加入 `wiki/index.md` 和 [[../知识库图谱入口|知识库图谱入口]]
- 在 [[自动化维护流程|自动化维护流程]] 的 Tech Radar 部分链接到领域雷达页
- 在 [[../domains/Java现代后端进化路线|Java 现代后端进化路线]] 增加与 agent 工程生态的关联
- 将 [[Codex工作台治理|Codex 工作台治理]] 与 [[Codex Chrome扩展NativeHost修复|Codex Chrome 扩展 Native Host 修复]] 接入 [[../知识库图谱入口|知识库图谱入口]]，避免默认图谱因隐藏 `index` 而出现孤立运行手册
- 将 7 个项目页全部接入图谱入口；CRRC 三端保留已有真实调用链连接，不额外制造项目间连线

## 不建议硬补的链接

- `raw/inbox/` 原始资料不需要互相反链；它们通过 `source_refs` 被 wiki 页面追溯即可
- `templates/`、`README`、`log`、`index` 这类机器入口不需要为了图谱好看而增加正文链接
- 稳定 SOP 页面不需要强行链接每个新主题，只在流程职责变化时更新

## 后续维护规则

- 新增 `wiki/domains/` 页面：必须加入 `wiki/index.md` 的“领域知识”和 [[../知识库图谱入口|知识库图谱入口]]
- 新增 `wiki/operations/` 页面：必须加入 `wiki/index.md` 的“操作知识”和 [[../知识库图谱入口|知识库图谱入口]]
- 新增或升级 `wiki/projects/` 页面：必须加入 `wiki/index.md` 的“项目”和 [[../知识库图谱入口|知识库图谱入口]]；项目之间只在存在真实系统、数据或交付依赖时互链
- 每周复盘时检查孤立长期页；只有长期页需要优先处理，raw source 孤立是正常状态
- 如果一个 raw topic 连续两周进入复盘，再考虑创建独立 wiki 页并建立双向链接
