---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07593"
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

# What Makes a Good Bug Report for an AI Agent?

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.07593
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：20
- 命中关键词：agent, agents, ai, llm, model, developer, benchmark, workflow, repository

## 自动摘要

arXiv:2607.07593v1 Announce Type: new Abstract: Automated program repair (APR) agents are transitioning from research benchmarks to developer workflows, yet they still begin with bug reports written for human developers. While decades of research have established what makes a good bug report for humans (e.g., steps to reproduce, stack traces), it remains unclear whether these features transfer to LLM-based agents. We study this question in two analyses. First, we use statistical modeling to examine associations between 27 bug-report features and repair success across 433 SWE-bench Verified issues attempted by 87 repair agents. We find that fix suggestions, reproduction scripts, repository source code, and localization info are associated with higher resolution likelihood, while longer reports are associated with lower odds. Second, we conduct controlled ablations across 2 models and 17 problem-statement mutations on SWE-bench Pro, varying the information available to an agent while holding the underlying task fixed. We remove or isolate selected bug-report content, delete fault-localization cues, and test structural changes that flatten lists or remove section headers. We find that


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
