---
type: agent-contract
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - 00-开始使用.md
  - wiki/operations/采集消化复盘SOP.md
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

维护 `E:\AIWorkspace\CxMVault` 这个可持续进化的个人知识库。所有 agent 都应把它视为普通文件夹加 Markdown wiki，而不是绑定某个供应商的专有记忆系统。

## 方法来源

本库采用混合方法：

- Karpathy LLM Wiki：`raw/` 保存不可变来源，`wiki/` 保存编译后的知识，`schema/` 保存 agent 规则
- PARA：用项目、领域、资源、归档的思想判断行动性
- Johnny Decimal：用稳定编号和清晰入口降低长期混乱
- Obsidian daily/weekly review：用周期复盘让知识持续变干净

## 目录职责

- `raw/`：原始资料、导入资料和 legacy source。agent 可以读取，不应随意改写已有来源
- `raw/inbox/`：新文章、网页、截图、文件、想法的统一收件箱
- `wiki/`：编译后的知识页。agent 可以创建和更新，但必须保持来源可追溯
- `reviews/`：每日消化、每周复盘、每月整理
- `templates/`：采集、消化、复盘模板
- `schema/`：维护规则和跨 agent 适配入口。修改前先确认影响范围
- `logs/`：系统维护日志。重大 ingest、query、lint、迁移都要记录
- `outputs/`：报告、图谱、导出物
- `tools/`：验证和迁移脚本

## 工作流

### capture

1. 新资料先放入 `raw/inbox/` 对应子目录
2. 不确定归属的内容放入 `raw/inbox/ideas/`
3. 截图需要同名 Markdown 说明来源、日期和待解决问题

### ingest

1. 读取 `00-开始使用.md` 和 `wiki/operations/采集消化复盘SOP.md`
2. 读取 `raw/inbox/` 新内容
3. 查 `wiki/index.md` 判断是否已有相关页面
4. 编译或更新 `wiki/` 页面
5. 更新 `wiki/index.md`
6. 更新当天 `reviews/daily/YYYY-MM-DD.md`
7. 向 `wiki/log.md` 追加记录

### query

1. 先读 `wiki/index.md`
2. 再读目标页面和必要 raw source
3. 回答时说明来源和置信度
4. 有长期价值的回答沉淀回 `wiki/`

### review

每日消化 inbox；每周把 repeated patterns 提升为 wiki 页面、SOP、项目规则或概念页；每月检查旧库迁移、断链、过期结论和结构漂移。

### lint

运行：

```powershell
& 'E:\AIWorkspace\CxMVault\tools\Test-CxMVault.ps1'
```

检查断链、孤立页、替换字符乱码、控制字符、无来源断言、重复主题、敏感信息风险、旧路径误写入和过期结论。

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

