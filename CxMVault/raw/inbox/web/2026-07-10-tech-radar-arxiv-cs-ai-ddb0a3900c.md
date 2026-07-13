---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07097"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: compiled
risk_level: medium
compile_decision: compile
confidence: EXTRACTED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# Operational Reframing and Approval-Framed Delegation in Multi-Agent LLM Safety

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.07097
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：15
- 命中关键词：agent, ai, llm, claude, benchmark, evaluation

## 自动摘要

arXiv:2607.07097v1 Announce Type: new Abstract: Safety evaluations of multi-agent LLM systems often compare a direct prompt with a planner-executor pipeline and report the difference as a single "pipeline effect." We argue that this aggregate is difficult to interpret because it conflates three mechanisms: harmful intent may be reframed as plausible operational work, the planner may refuse or transform the request, and the executor may act under delegation prompts implying prior approval. To separate these factors, we introduce a five-condition controlled contrast design, evaluated on 30 synthetic harmful scenarios and an exploratory external validation set from four agent-safety benchmarks using LLM-judged compliance. Our results show that aggregate pipeline safety is not a stable architectural property. Operational reframing is the most portable risk signal, increasing compliance for GPT, Gemini, and DeepSeek across both scenario sets, while Claude is comparatively resistant. Planner behavior can offset this risk mainly through refusal; however, when the planner produces executable steps, the executor may become more compliant than under the direct operational baseline. Approval-


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
