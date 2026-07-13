---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02879"
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

# MedCalc-Pro: Solving Complex Medical Calculations with LLM Agents

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.02879
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：18
- 命中关键词：agent, agents, ai, llm, model, benchmark, evaluation

## 自动摘要

arXiv:2607.02879v1 Announce Type: new Abstract: Current benchmarks for evaluating large language models (LLMs) in medical calculation are largely based on simplified settings, where each patient case corresponds to a single calculator and the required tool is explicitly specified in the query. However, real clinical scenarios often require multiple calculators for joint evaluation, nested-scale calculation, and fuzzy queries that do not directly specify the target calculator. To this end, we propose a new medical calculation benchmark, MedCalc-Pro, which covers three progressively challenging task settings: single-calculator, multi-calculator, and nested-calculator calculation settings. MedCalc-Pro contains 2,268 real-world clinical cases, covering 77 medical calculators across 14 clinical departments. Meanwhile, to address the limited performance of existing frameworks and methods in complex clinical scenarios, we further propose a more generalizable agent framework that supports multi-tool selection and nested-tool calling, while suppressing parameter error propagation through structured validation and evidence review. We conduct systematic comparisons across open-source, closed-


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
