---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05666"
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

# What Do AI Agents Actually Change? An Empirical Taxonomy of Mutation Patterns in Performance-Improving Pull Requests

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.05666
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, ai, llm, coding

## 自动摘要

arXiv:2607.05666v1 Announce Type: new Abstract: AI coding agents are black boxes: we cannot inspect how they generate code, but we can inspect what they change. This distinction matters for search-based software engineering (SBSE), where techniques such as genetic improvement (in the performance-optimisation application we study) depend on mutation operators that reflect how code is actually transformed. Fewer than 1% of the 33,596 agent PRs in AIDev-pop target performance, making each case a rare window into otherwise opaque agent behaviour. We classify 1,254 performance-relevant diff hunks from 216 of these PRs, spanning five agent systems, against the 18-category syntactic mutation taxonomy of Even-Mendoza et al. (2025) using a dual-LLM intersection pipeline. Three categories dominate: name modification (37.0%), object creation (26.4%), and type change (22.7%), a profile markedly different from prior GI corpora where no change accounted for 84%. Each agent's deployed system commits to a distinctive mutation vocabulary, and each performance strategy activates a largely disjoint category subset. Agent identity and target strategy are therefore informative priors that narrow the ef


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
