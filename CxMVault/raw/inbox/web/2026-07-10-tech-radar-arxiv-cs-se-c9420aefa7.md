---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2604.11950"
source_feed: "https://rss.arxiv.org/rss/cs.SE"
source_name: "arXiv cs.SE"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: archived
risk_level: medium
compile_decision: reference-only
confidence: EXTRACTED
tags:
  - inbox
  - paper
  - software-engineering
  - tech-radar
---

# AnyPoC: Universal Proof-of-Concept Test Generation for Scalable LLM-Based Bug Detection

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2604.11950
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, ai, llm, knowledge

## 自动摘要

arXiv:2604.11950v2 Announce Type: replace Abstract: While recent LLM-based agents can identify many candidate bugs in source code, their reports remain static hypotheses that require manual validation, limiting the practicality of automated bug detection. We frame this challenge as a test generation task: given a candidate report, synthesizing an executable proof-of-concept (PoC) - such as a script, command sequence, or crafted input - to trigger the suspected defect. Automated PoC generation can act as a scalable validation oracle, enabling end-to-end autonomous bug detection by providing concrete execution evidence. However, naive LLM agents are unreliable validators: they are biased toward "success" and may reward-hack by producing plausible but non-functional PoCs or even hallucinated traces. To address this, we present ANYPoC, a general multi-agent framework that (1) analyzes and fact-checks a candidate bug report, (2) iteratively synthesizes and executes a PoC while collecting execution traces, and (3) independently re-executes and scrutinizes the PoC to mitigate hallucination and reward hacking. In addition, ANYPoC also continuously extracts and evolves a PoC knowledge base 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
