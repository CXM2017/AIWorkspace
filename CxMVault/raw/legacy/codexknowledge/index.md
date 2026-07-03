---
type: legacy-source-index
status: active
created: 2026-07-02
updated: 2026-07-02
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

- 盘点时间：2026-07-02 10:42:37
- Markdown 总数：331
- 排除 `.tmp` 后 Markdown：273
- 项目数：12
- 旧库路径：`E:\CodeXData\CodeXKnowledge`

## 项目来源

- `damaihelper-main`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\damaihelper-main`
- `MatDao`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\MatDao`
- `matdao_api`：Markdown 24，README 13，非 README 笔记 10，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\matdao_api`
- `matdao-web-admin`：Markdown 21，README 13，非 README 笔记 7，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\matdao-web-admin`
- `matdao-web-index`：Markdown 21，README 14，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\matdao-web-index`
- `MyExcel`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\MyExcel`
- `Ngrok`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\Ngrok`
- `portal-login-test`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\portal-login-test`
- `SteelNodeManage_admin`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\SteelNodeManage_admin`
- `SteelProblems`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\SteelProblems`
- `SteelTechnologyNode_api`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\SteelTechnologyNode_api`
- `yudao-cloud`：Markdown 20，README 13，非 README 笔记 6，旧路径 `E:\CodeXData\CodeXKnowledge\10-projects\yudao-cloud`

## 全局知识来源

- `20-runbooks`：7 个 Markdown
- `30-decisions`：3 个 Markdown
- `40-error-cases`：2 个 Markdown
- `50-code-anchors`：1 个 Markdown
- `70-compiled-wiki`：3 个 Markdown
- `80-templates`：7 个 Markdown

## 迁移规则

- `raw/legacy/codexknowledge/` 只保存来源索引和迁移说明，不直接复制旧库全文
- 旧项目的可复用经验编译到 `wiki/projects/<项目名>/`
- 跨项目流程、决策和错误案例编译到 `wiki/operations/`
- 旧库 `.tmp/` 仅作为历史备份提示，不进入新 wiki 查询主路径
- 旧库继续可读，直到新库覆盖主要项目记忆入口
