---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07379"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: EXTRACTED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# Physics-Audited Agentic Discovery in Scientific Machine Learning

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.07379
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：17
- 命中关键词：agent, agents, ai, llm, model, workflow

## 自动摘要

arXiv:2607.07379v1 Announce Type: new Abstract: In agentic scientific machine learning (SciML), large language model (LLM) agents can discover surrogate models and select one by an automated score, typically an error metric. A low error, however, does not establish that the predicted fields satisfy the physics that matter for mechanics, such as boundary conditions, superposition, stiffness scaling, or causality. We introduce Physics-Audited Agentic SciML (PA-SciML), a verification-first workflow for agentic SciML discovery. The workflow fixes a scoring evaluator before search, derives reviewable machine-checkable physics requirements, checks each trained candidate on its outputs, and separately searches prescribed input ranges or measured load-history spans for high-violation cases without reference solution fields. A surrogate is reported as verified only under the stated checks. When enabled, the workflow also adds advisory numerical probes before training and tests one modeling change at a time to record which isolated edits are associated with score gains before reuse. In the reported computational-solid-mechanics numerical examples, the static elasticity run selects a surrogat


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
