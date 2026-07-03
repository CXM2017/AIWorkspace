---
type: operation
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  - https://fortelabs.com/blog/para/
  - https://bagerbach.com/blog/weekly-review-obsidian/
confidence: EXTRACTED
tags:
  - sop
  - capture
  - ingest
  - review
---

# 采集消化复盘 SOP

## 总原则

`raw/inbox/` 是收件箱，不是垃圾桶。任何新文章、新知识、网页内容、截图、报错、想法都可以先进入 inbox，但必须通过每日消化和每周复盘清空或标记。

## 1. Capture 采集

### 放置规则

| 类型 | 路径 | 命名 |
| --- | --- | --- |
| 网页、博客、知乎、公众号 | `raw/inbox/web/` | `YYYY-MM-DD-来源-标题.md` |
| 长文、PDF 摘录、研究资料 | `raw/inbox/articles/` | `YYYY-MM-DD-标题.md` |
| 截图、错误图片、界面图 | `raw/inbox/screenshots/` | `YYYY-MM-DD-标题.png` + 同名 `.md` |
| 文件、附件、导出包 | `raw/inbox/files/` | 保留原文件名，必要时加日期前缀 |
| 临时想法 | `raw/inbox/ideas/` | `YYYY-MM-DD-一句话主题.md` |

### 截图要求

截图旁边最好有同名 Markdown，写清：

- 来源：哪个网页、软件、项目或聊天
- 时间：明确日期
- 问题：为什么要保存
- 期望：后续要转成什么知识

## 2. Daily Ingest 每日消化

每天执行一次，最晚睡前或第二天开始前完成。

自动化默认在每天 17:00 执行，先运行本地 runner 生成 `run-result.json`，再由 Codex 根据 pending 列表执行判断性编译。

步骤：

1. 扫描 `raw/inbox/` 新增内容
2. 判断每条内容是丢弃、暂存、编译还是待复盘
3. 编译有价值内容到 `wiki/`
4. 更新 `wiki/index.md`
5. 更新当天 `reviews/daily/YYYY-MM-DD.md`
6. 追加 `wiki/log.md`

产出：

- 一个 daily note
- 若干 wiki 页面更新
- inbox 明确状态

### 自动化状态字段

每条可被自动化识别的 raw source 尽量包含：

- `processing_status`：`inbox`、`compiled`、`review`、`archived`、`discarded`
- `risk_level`：`low`、`medium`、`high`、`unreviewed`
- `compile_decision`：`compile`、`reference-only`、`weekly-review`、`discard`、`unreviewed`

缺少状态字段或状态为 `inbox/unreviewed` 时，runner 会视为待处理。处理完成后必须更新状态，避免重复消化。

### 失败处理

- runner 失败：读取 `outputs/automation/cxmvault-maintenance/run-result.json` 和 `run-log.jsonl`
- 健康检查失败：先修复断链、frontmatter、乱码或结构问题，再继续编译
- 敏感信息命中：只写入 run-result 和 daily 的风险提示，不写入 wiki 正文
- 高风险平台规避内容：只做 raw 归档和风险结论，不生成可执行 SOP

## 3. Weekly Review 每周复盘

每周固定执行一次，建议周日或周一。

检查：

- 本周 daily notes
- `raw/inbox/` 未处理内容
- `wiki/log.md`
- 项目桥接页
- 健康检查报告

要做的事：

1. 合并重复主题
2. 把反复出现的问题提升为 SOP
3. 把项目经验提升为项目页或项目 runbook
4. 把概念性内容提升到 `wiki/concepts/`
5. 把纯资料归入 `raw/` 对应长期位置

## 4. Monthly Review 每月整理

每月检查一次结构是否仍清晰。

重点：

- inbox 是否堆积
- wiki 是否有断链和孤立页
- 旧 `CodeXKnowledge` 哪些经验已迁移，哪些仍只桥接
- `agentMemory` 哪些项目记忆应编译进新库
- 是否需要新增模板、SOP 或目录

## 5. Agent 执行提示

每日消化：

```text
请按 CxMVault 的采集消化复盘 SOP，消化 raw/inbox 的新增内容，更新 wiki、daily note 和 wiki/log。
```

每周复盘：

```text
请按 CxMVault 的每周复盘流程，汇总本周 daily notes、inbox 和 wiki/log，沉淀可复用知识并运行健康检查。
```
