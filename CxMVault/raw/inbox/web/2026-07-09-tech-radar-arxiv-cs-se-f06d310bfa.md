---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05482"
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

# TypeGo: An OS Runtime for Embodied Agents

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.05482
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, llm, model, skill

## 自动摘要

arXiv:2607.05482v1 Announce Type: new Abstract: Large language models (LLMs) can plan behavior for embodied agents from natural language, but treating the LLM as a request/response oracle on the critical path is fundamentally at odds with real-time control and concurrent goals. We argue for an operating-system-style runtime for embodied agents, and instantiate this idea in an early prototype, TypeGo. TypeGo structures LLM-based planning as asynchronous loops at multiple timescales that overlap with execution, and manages the agent's physical body like an OS manages hardware: the Skill Kernel arbitrates typed physical subsystems among concurrent per-task processes, a scheduler preempts them and resumes or replaces each by source, and speculative skill streaming hides LLM latency behind ongoing motion, while a fast first-action path yields visible feedback within a second. Users program behavior through natural language prescriptions that TypeGo dispatches to the LLM-based planners or compiles into low-latency interrupt handlers. Our prototype of Kalos, a Unitree Go2 quadruped, provides preliminary evidence for the design: in our current task suite, it cuts per-step delay by 50% over


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
