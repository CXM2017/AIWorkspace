---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.06065"
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

# SWE-Review: Closing the Loop on Issue Resolution with Agentic Code Review

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.06065
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：15
- 命中关键词：agent, agents, ai, model, coding, repository

## 自动摘要

arXiv:2607.06065v1 Announce Type: new Abstract: Coding agents increasingly generate pull requests (PRs) for real-world software issues, yet one-shot PR generation remains open-loop: the PR is proposed without systematic review, diagnosis, or revision. We introduce \textbf{SWE-Review}, a framework for closing this loop with agentic code review. Given an issue and an AI-generated PR, a reviewer agent explores the repository, decides whether the PR should be accepted, and provides structured feedback for revision. We evaluate this setting with our proposed \textbf{SWE-Review-Bench} to measure both review correctness and downstream revision usefulness. We further curate \textbf{SWE-Review-Traj} dataset to study broader applications of agentic review and fill the data-scarcity gap for open reviewer training. Experiments show that agentic review continuously improves PRs through a generate-review-revise loop, outperforms single-turn fixed-context review in both decision accuracy and resolve rate after revision, transfers beyond review to improve issue-resolution models, and enables effective and efficient test-time scaling. These results position agentic code review as a practical mechan


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
