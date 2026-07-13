---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05943"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-08T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: INFERRED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# SearchEyes: Towards Frontier Multimodal Deep Search Intelligence via Search World Simulation

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.05943
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：15
- 命中关键词：agent, agents, ai, model, benchmark, knowledge

## 自动摘要

arXiv:2607.05943v1 Announce Type: new Abstract: Training multimodal search agents to perform multi-hop reasoning remains challenging due to a fundamental structural disconnect: existing pipelines construct training data, search environments, and reward signals independently, causing synthesized structural metadata to be discarded, environments to rely on irreproducible external engines, and RL rewards to remain sparse at the trajectory level. We present \textbf{SearchEyes}, which uses a typed knowledge graph as the backbone of a \emph{simulated search world} that unifies all three components. We propose \textbf{Perception-Knowledge Chains (PKC)} to sample constrained multi-hop paths over the visual-knowledge intersection of Wikidata5M, retaining hop-level entity metadata that simultaneously defines a self-contained search world and step-level reward anchors. We further propose \textbf{Hop-Anchored Policy Optimization (HaPO)}, which reuses these anchors for step-level credit assignment without a separately trained process reward model. Experiments on six multimodal knowledge-intensive benchmarks show that SearchEyes achieves state-of-the-art performance among open-source multimodal 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
