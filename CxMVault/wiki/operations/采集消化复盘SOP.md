---
type: operation
status: active
created: 2026-07-02
updated: 2026-07-29
source_refs:
  - https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  - https://fortelabs.com/blog/para/
  - https://bagerbach.com/blog/weekly-review-obsidian/
  - wiki/operations/自动化维护流程.md
confidence: EXTRACTED
tags:
  - sop
  - capture
  - ingest
  - review
---

# 采集消化复盘 SOP

## 总原则

`raw/inbox/` 是收件箱和来源证据，不是垃圾桶。所谓“清空 inbox”是让每条来源获得明确状态，不是删除或搬走原始材料。执行时间、runner 和通知以 [[自动化维护流程]] 为准。

## 1. Capture

| 类型 | 路径 | 命名 |
| --- | --- | --- |
| 网页、博客、公众号 | `raw/inbox/web/` | `YYYY-MM-DD-来源-标题.md` |
| 长文、PDF 摘录 | `raw/inbox/articles/` | `YYYY-MM-DD-标题.md` |
| 截图、错误图片 | `raw/inbox/screenshots/` | 图片加同名说明 Markdown |
| 文件、附件、导出包 | `raw/inbox/files/` | 保留原名，必要时加日期 |
| 临时想法 | `raw/inbox/ideas/` | `YYYY-MM-DD-一句话主题.md` |

截图说明至少记录来源、日期、保存原因和预期处理结果；不要把凭据或完整敏感响应写入说明。

## 2. Daily Ingest

1. 扫描新增或变化的 raw source
2. 对照 `wiki/index.md` 与现有项目页查重
3. 为每条来源选择 `compiled / archived / discarded / review`
4. 有长期价值时编译或更新 `wiki/`，并保持 `source_refs`
5. 更新当天 daily、`wiki/index.md` 和 `wiki/log.md`
6. 重新运行 runner 与健康检查，确认状态幂等

自动化可识别字段：

- `processing_status`：`inbox`、`compiled`、`review`、`archived`、`discarded`
- `risk_level`：`low`、`medium`、`high`、`unreviewed`
- `compile_decision`：`compile`、`reference-only`、`weekly-review`、`discard`、`unreviewed`

缺少状态字段，或仍为 `inbox/unreviewed`，属于 Daily pending。

## 3. Review Backlog

进入 `review` 或 `weekly-review` 的来源必须补充：

```yaml
review_owner: CxM
review_due: YYYY-MM-DD
decision_reason: 简短说明为什么暂不闭环
last_seen: YYYY-MM-DD
```

复核后只能：

- 编译并标记 `compiled`
- 仅保留来源并标记 `archived`
- 明确无价值并标记 `discarded`
- 仍需等待时保留 `review`，但更新原因、负责人、下一复核日期和 `last_seen`

Weekly Review 汇总 daily、Review backlog、项目页、`wiki/log.md` 与健康报告，合并重复主题，并将反复出现的流程提升为 Skill、项目规则或 operation。

## 4. Monthly Review

检查项目登记漂移、旧库桥接、过期结论、断链、孤立页、长期 review 项以及是否需要新增或合并 Skill。历史 raw source 仍保持可追溯，不以“整理”为由删除。

## 5. 失败与安全

- runner 失败：读取对应 `run-result.json` 与 `run-log.jsonl`
- 健康检查失败：先修复 frontmatter、断链、乱码或 Registry 漂移
- 敏感信息命中：只记录风险和来源位置，不复制敏感正文
- 高风险内容：保留来源和风险结论，不编译为可直接执行的规避教程
- Nacos 内容只能按项目规则只读核对；本 SOP 和自动化均不得发布、导入或覆盖 Nacos
