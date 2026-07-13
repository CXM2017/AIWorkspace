---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02873"
source_feed: "https://rss.arxiv.org/rss/cs.SE"
source_name: "arXiv cs.SE"
source_type: "web"
published_at: "2026-07-07T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: UNVERIFIED
tags:
  - inbox
  - paper
  - software-engineering
  - tech-radar
---

# Determinants and Limits of LLM Security-Tool Orchestration: A Study with HexStrike-AI

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.02873
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：19
- 命中关键词：agent, agents, ai, llm, model, security, protocol, tools

## 自动摘要

arXiv:2607.02873v1 Announce Type: new Abstract: Large language model agents driving security tool suites over the Model Context Protocol are increasingly common. Yet the factors that bound their capability remain poorly characterized: how much depends on the model versus the client that drives it, whether constraining the agent to the orchestrator's own tools helps, and where capability is limited by reasoning rather than by missing tools. Using HexStrikeAI, an open-source orchestrator that exposes 150+ tools, as a testbed, we follow a methodology that evaluates the system, diagnoses its failures, and applies targeted improvements. We run 86 picoCTF challenges across seven categories and three difficulty tiers, under three tool-access regimes and three model/client configurations (774 trials). We then apply corrections to existing tools, agent-behavior changes, and eleven new capability tools, and re-run the previously-unsuccessful trials. The diagnosis isolates the driving client as a first-order factor for a fixed model (a 2.1 * gap between two DeepSeek clients) and a monotonic difficulty gradient, with the largest gains in the mid tier. The overall solve rate rises from 55.4% to


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
