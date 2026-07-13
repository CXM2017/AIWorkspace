---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://simonwillison.net/2026/Jul/9/gpt-5-6/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-09T19:46:38+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: EXTRACTED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# The new GPT-5.6 family: Luna, Terra, Sol

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/9/gpt-5-6/#atom-everything
- 发布时间：2026-07-09T19:46:38+00:00
- 采集分数：19
- 命中关键词：agent, agents, ai, model, openai, claude, benchmark, evaluation, workflow, knowledge

## 自动摘要

OpenAI's latest flagship model hit general availability this morning , and comes in three sizes: Luna, Terra, and Sol (from smallest to largest). The new models are priced per 1M input/output tokens as Luna $1/$6, Terra $2.50/$15, Sol $5/$30. For comparison, the Claude Opus series are $5/$25 and the Claude Fable 5 is $10/$50, but price-per-million tokens doesn't tell us much now that the number of reasoning tokens can differ so much between models for the same task. All three models have a February 16th 2026 knowledge cutoff, a million token context window, and 128,000 maximum output tokens. OpenAI's biggest benchmark claim concerns long-running agentic performance, with one benchmark showing all three models outperforming Claude Fable 5: We trained GPT-5.6 to get more useful work from every token. On Agents’ Last Exam , an evaluation of long-running professional workflows across 55 fields, GPT-5.6 Sol sets a new high of 53.6, eclipsing Claude Fable 5 (adaptive reasoning) by 13.1 points. Even at medium reasoning, it beats Fable 5 by 11.4 points at roughly one-quarter the estimated cost. That efficiency extends to smaller models, which are essential to making intelligence more abund


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
