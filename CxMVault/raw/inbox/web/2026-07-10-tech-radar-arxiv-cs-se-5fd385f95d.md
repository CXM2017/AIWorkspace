---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.06873"
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

# Mining Workflow Graphs for Black-Box Boundary Testing of Conversational LLM Agents

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.06873
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：18
- 命中关键词：agent, agents, ai, llm, model, benchmark, workflow

## 自动摘要

arXiv:2607.06873v1 Announce Type: new Abstract: Conversational LLM agents can cause real-world harm when their internal workflows fail, such as completing a transaction without confirmation. Testing these state-dependent failures is difficult because critical boundaries, such as identity checks and confirmation gates, are hidden behind multi-turn conversational prerequisites, rendering them inaccessible to standard tests. We present AgentEval, a black-box testing framework that discovers and stresses these stateful boundaries. AgentEval interacts with an agent to mine a \emph{conversational workflow graph}, a model of its behavior. Instead of prompting blindly, AgentEval uses this graph's structure to enumerate specific guards and prerequisites as test targets, replaying the conversational path to a boundary before applying a perturbation. AgentEval then executes each test, determining whether it passes or fails using only the conversation turns. We benchmark AgentEval against a privileged, white-box auditor with access to the agent's underlying source code, which AgentEval never sees. On four $\tau^3$-bench agents, AgentEval successfully generates tests covering $23$--$38$ distinc


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
