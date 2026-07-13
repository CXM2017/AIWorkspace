---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02577"
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

# Benchmarking the Benchmarks: A Validity Audit of Tool-Calling Evaluation

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.02577
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：21
- 命中关键词：agent, agents, ai, llm, model, benchmark, evaluation, mcp

## 自动摘要

arXiv:2607.02577v1 Announce Type: new Abstract: Tool-calling benchmarks are increasingly used to rank language-model agents, yet their scores are often treated as ground truth without validating the evaluators themselves. We present a systematic validity and reproducibility audit of four major tool-calling benchmark families: BFCL v4, {\tau}2-Bench, LiveMCPBench, and MCP-Atlas. Across 496 expert-reviewed benchmark tasks, we find 92 evaluator-human disagreements, corresponding to an 18.5% misalignment rate. The failures are not isolated annotation mistakes: deterministic benchmarks exhibit brittle state matching, trajectory lock-in, incorrect ground truths, substring-based communication failures, and reward-basis misalignment, while LLM-judge benchmarks exhibit rubric drift, hallucinated completion, answer-only scoring, and substantial run-to-run variance. In LiveMCPBench, 23 repeated evaluations of the same setup produce scores ranging from 57.9% to 76.8%, a spread of 18.9 percentage points, large enough to change leaderboard conclusions. These results show that current tool-calling scores can reflect evaluator artifacts rather than agent capability. We introduce a unified taxonomy


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
