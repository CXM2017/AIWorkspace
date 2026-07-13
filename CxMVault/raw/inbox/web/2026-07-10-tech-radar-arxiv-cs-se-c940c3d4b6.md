---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07052"
source_feed: "https://rss.arxiv.org/rss/cs.SE"
source_name: "arXiv cs.SE"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: EXTRACTED
tags:
  - inbox
  - paper
  - software-engineering
  - tech-radar
---

# Progressive Crystallization: Turning Agent Exploration into Deterministic, Lower-Cost Workflows in Production

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.07052
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：18
- 命中关键词：agent, agents, ai, llm, model, cloud, workflow

## 自动摘要

arXiv:2607.07052v1 Announce Type: new Abstract: AI agents deployed for IT operations are typically permanent cost centers because every execution requires full LLM inference, even for previously solved problems. This paper introduces progressive crystallization, a lifecycle that treats agent exploration as a discovery mechanism rather than a permanent execution model. It defines a three-stage execution taxonomy, from fully agent-orchestrated to hybrid to fully deterministic workflows, together with an evidence-based promotion mechanism that converts repeatedly validated agent behaviors into cheaper and more reproducible deterministic workflows, while automatically demoting workflows that regress. Evaluated on a production cloud networking AIOps system processing tens of thousands of incidents per month, the approach increased deterministic execution from 0% to 45% over eight months, reduced per-incident agent costs by more than 70% despite doubling incident volume, and improved safety through greater reproducibility and auditability. The paper also presents the execution taxonomy, promotion and demotion criteria, trace extraction methodology, economic model, safety considerations, 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
