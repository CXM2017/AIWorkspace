---
type: project
status: active
created: 2026-07-02
updated: 2026-10-16
project_id: MyExcel
project_lifecycle: active
knowledge_tier: full
config_source: local-files
config_authority: project-files
agentmemory_status: verified
codegraph_status: not-applicable
verification_status: verified
last_capability_review: 2026-09-08
last_verified: 2026-07-29
source_refs:
  - E:\CodeXData\MyExcel\AGENTS.md
  - E:\CodeXData\MyExcel\generate_config_docx.py
  - E:\CodeXData\MyExcel\batch_generate_all_config_docx.py
  - E:\CodeXData\MyExcel\batch_verify_all_config_docx.py
  - E:\CodeXData\MyExcel\verify_generated_docx.py
  - D:\CodeX\.codex\skills\xlsx-structure-preserving-edits\SKILL.md
confidence: EXTRACTED
tags:
  - project
  - MyExcel
  - spreadsheet
  - document
---

# MyExcel

## 项目定位

`MyExcel` 是非 Git 的表格、Word、PDF、图片与批量文件处理工作区。源业务文件默认只读，除非用户明确要求原地修改，否则生成新输出。

## 主要工作流

- 合并发票工作簿，按业务记录组排序，保持续行关系并做编号窄修复
- 从现有单元格文本抽取目标列，同时逐单元格证明源列未变化
- 将发票、PDF 与截图按现有样例目录复制整理，来源目录不动
- 生成、批量生成、验证与打包组件材料配置 DOCX

## 结构保持与工具路由

- 只修改用户指定的工作表、单元格、列或记录组，不重建整表
- 保留合并单元格、样式、行列尺寸、打印设置、筛选、冻结窗格、工作表顺序和续行归属
- 含合并单元格、原布局或续行的任务必须使用 `xlsx-structure-preserving-edits`；普通新建或计算可使用 xlsx/spreadsheets
- Word、PDF 任务使用对应 Skill，并优先复用工作区现有生成和验证脚本
- 图表、图片、VBA、外链、数据验证或复杂多 Sheet 依赖存在时先评估工具是否能无损保持，不能确认时不做原地编辑

## 验证与安全

- xlsx 保存后重开，核对工作表数量、维度、非空单元格、合并范围、目标值、源值未变、公式错误与 ZIP 完整性
- 排序和合并任务验证记录组完整、续行归属和编号连续；批量整理验证源/目标数量及失败清单
- DOCX 使用现有验证脚本，必要时再做 LibreOffice/PDF 视觉抽查
- 发票、报价、客户、合同和业务附件视为敏感业务数据；CxMVault 与记忆只保存可复用规则、字段映射方法、稳定根因和脚本入口
- 工作区详细规则见 `E:\CodeXData\MyExcel\AGENTS.md`

## 历史生成器入口（2026-10-16整理）

- 已交付工具为 `dist/组件材料配置表生成器_控制台版.exe`，说明为根目录 `组件材料配置表生成器_使用说明.md`。旧GUI曾因tkinter失败。对话 `019e2a16-49a8-7be0-8d98-f63eda70faab` 记录47张表、506条明细的历史验证，使用前核对文件与版本。
- `generate_technical_params.py` 曾修复Word编号被XML文本节点拆行：同一段落内文本直接拼接，不额外插换行。来源 `019e3068-cfa9-72d0-85d9-9062cbfd42a2`，本次仅整理，未重新生成业务文档。

## 记忆状态说明

`E:\CodeXData\agentMemory\MyExcel` 当前可作为未来项目记忆路径，但未把业务文件正文或敏感字段作为记忆来源；若启用 MCP，只写经过脱敏的可复用方法。
