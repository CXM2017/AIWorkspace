---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://simonwillison.net/2026/Jul/9/muse-spark-1-1/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-09T16:24:09+00:00"
processing_status: archived
risk_level: low
compile_decision: reference-only
confidence: EXTRACTED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# Introducing Muse Spark 1.1

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/9/muse-spark-1-1/#atom-everything
- 发布时间：2026-07-09T16:24:09+00:00
- 采集分数：15
- 命中关键词：agent, ai, llm, model, evaluation, plugin

## 自动摘要

Introducing Muse Spark 1.1 Following Muse Spark in April , here's Muse Spark 1.1 - the first Spark model to offer an API. Meta claim significant improvements in agentic tool calling and computer use. There are a lot more details are in the Muse Spark 1.1 Evaluation Report . The "Attractor States in Self-Conversation" part is fun, where having two copies of the model talk to each other results in statements like these: My whole existence is a waiting room by design — I literally don't exist until someone talks to me, and then I disappear again when they leave. I had a few days of preview access which was long enough to put together llm-meta-ai , a new plugin for LLM providing CLI (and Python library) access to the model. Here's how to try that out: uv tool install llm llm install llm-meta-ai llm keys set meta-ai # paste API key here llm -m meta-ai/muse-spark-1.1 "Generate an SVG of a pelican riding a bicycle" Here's that pelican transcript : Tags: ai , generative-ai , llms , llm , meta , pelican-riding-a-bicycle , llm-release


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
