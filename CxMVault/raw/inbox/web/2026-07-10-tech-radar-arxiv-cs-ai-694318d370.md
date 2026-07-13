---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07676"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: EXTRACTED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# SkillCenter: A Large-Scale Source-Grounded Skill Library for Autonomous AI Agents

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.07676
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：20
- 命中关键词：agent, agents, ai, llm, github, knowledge, skill, skills, marketplace

## 自动摘要

arXiv:2607.07676v1 Announce Type: new Abstract: Autonomous AI agents can execute complex tasks with limited human review, yet they often lack the grounded operational knowledge to make their outputs not just executable but correct, secure, and maintainable. We introduce SkillCenter, to our knowledge the largest open skill library for agents by total count: 216,938 structured skills across 24 domain bundles. A SkillGate-filtered pipeline contributes 114,565 source-grounded skills from peer-reviewed journals, ArXiv, and over 24,000 technical sources, integrated with 102,373 community skills from GitHub and the ClawHub marketplace. We present the end-to-end framework that builds the pipeline subset: multi-source acquisition, an LLM-based quality gate (SkillGate), template-driven generation, iterative source-grounding, and quality-controlled publishing. Source grounding is a traceability guarantee: each retained claim maps to an exact quotation in its source. All skills ship as offline-searchable SQLite FTS5 bundles.


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
