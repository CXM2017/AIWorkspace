---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02684"
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

# Can Coding Agents Implement Missed Compiler Optimizations? Evaluating LLM Agents on LLVM Peephole Optimizations

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.02684
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：19
- 命中关键词：agent, agents, ai, llm, model, coding, benchmark, evaluation

## 自动摘要

arXiv:2607.02684v1 Announce Type: new Abstract: Coding agents built on large language models are now capable of patching sizable real-world codebases, yet whether they can develop compiler optimizations remains an open question. To study this question, we introduce PeepholeBench, an evaluation framework whose tasks are constructed from real-world missed peephole optimizations reported against LLVM's InstCombine pass. Since missed peephole optimizations are typically fixed with small, localized patches, they offer a well-scoped but demanding testbed for coding agents: a correct fix demands rigorous reasoning about program semantics along with familiarity with optimizer-specific conventions. PeepholeBench derives its tasks from 21 resolved LLVM issues and 19 merged pull requests (PRs), supplies agents with only the issue context that existed before each fix, and assesses the resulting patches for both correctness and profitability. With PeepholeBench, we benchmark state-of-the-art coding agents on fixing missed peephole optimizations in LLVM's InstCombine pass, measuring their patches against the corresponding human-written fixes. We observe a tension between correctness and profitab


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
