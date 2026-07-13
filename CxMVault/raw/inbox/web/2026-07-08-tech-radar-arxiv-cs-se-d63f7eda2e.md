---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.02703"
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

# LLMoxie: Exploring Agentic AI for Scientific Software Development

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.02703
- 发布时间：2026-07-07T04:00:00+00:00
- 采集分数：22
- 命中关键词：agent, agents, ai, llm, coding, cloud, benchmark, workflow, knowledge, skill, plugin

## 自动摘要

arXiv:2607.02703v1 Announce Type: new Abstract: In this paper, we describe LLMoxie, an institutional AI platform whose three-tiered architecture supports multi-cloud and on-premise inference, a LiteLLM/MLflow control plane for authentication, budgeting, PII masking, and observability, and an application augmentation layer for AI coding agents. Layered on top, an open-source RSE-Plugins ecosystem encodes accumulated RSE knowledge as a Plugin-Agent-Skill hierarchy spanning scientific Python practice, domain-specific knowledge, a six-phase research-and-implement workflow, and project lifecycle management. Scientific software is judged less by raw code quality than by whether it can be cited, audited, reproduced, and extended. Off-the-shelf AI coding agents, optimized against commercial software benchmarks, are poorly calibrated for this setting: they ignore the conventions of the scientific Python libraries they invoke, mishandle sensitive or embargoed data, and leave decision trails that are difficult to reconstruct after the fact. We report on twenty months of practice at a university-based research software engineering (RSE) center, where RSEs embedded across astronomy, earth and c


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
