---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05785"
source_feed: "https://rss.arxiv.org/rss/cs.SE"
source_name: "arXiv cs.SE"
source_type: "web"
published_at: "2026-07-08T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: INFERRED
tags:
  - inbox
  - paper
  - software-engineering
  - tech-radar
---

# Can Large Language Models Generate Observability-Aware Code?

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.05785
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：15
- 命中关键词：agent, agents, ai, model, coding, evaluation

## 自动摘要

arXiv:2607.05785v1 Announce Type: new Abstract: Recent advances in coding agents have enabled the generation of increasingly complex software systems. While existing evaluations primarily focus on functional correctness, production systems must expose failure evidence to support observability. In this paper, we present a systematic study of observability in agent-generated systems. We examine whether agents can reconstruct source-level diagnostic semantics by restoring observability artifacts in 10 open-source and 8 industrial repositories. We also evaluate whether these artifacts translate into effective fault signals at runtime through 200 generated microservice systems deployed on Kubernetes with 13 injected faults. Our results reveal a consistent gap between diagnostic semantics at the source level and fault signals (i.e., explicit, fault-specific evidence) at runtime. At the source level, agents partially recover observability artifacts but struggle to capture key diagnostic semantics. At runtime, generated systems expose fault signals for only a small fraction of failures (up to 13.99\%), despite the presence of logging, suggesting that the generated observability artifacts m


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
