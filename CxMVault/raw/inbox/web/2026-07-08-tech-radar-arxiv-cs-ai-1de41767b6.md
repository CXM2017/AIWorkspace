---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02846"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-07T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: UNVERIFIED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# Object-Centric Environment Modeling for Agentic Tasks

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.02846
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：21
- 命中关键词：agent, agents, ai, llm, model, benchmark, rag, knowledge, skill, skills

## 自动摘要

arXiv:2607.02846v1 Announce Type: new Abstract: Large language model (LLM) agents can improve through accumulated experience, but free-form textual memories become difficult to maintain, validate, and reuse as interactions grow. Recent symbolic approaches learn executable skills or programmatic world models, yet often store local procedures or assume simplified dynamics. We propose Object-Centric Environment Modeling (OCM), which organizes experience into an executable object-centric environment model. OCM maintains two connected code bases: object knowledge, which defines environment entities and mechanisms as Python classes, and procedure knowledge, which records reusable interaction patterns that must import and use the object model. OCM works in an online setting: after each episode, OCM reflects on the trajectory, updates both knowledge bases, and verifies that all procedures execute against the updated object model. During future interaction, the agent uses progressive knowledge disclosure to inspect compact code signatures first and read source code only when needed. Experiments show that OCM achieves the best average rank across benchmarks and reduces invalid actions, demon


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
