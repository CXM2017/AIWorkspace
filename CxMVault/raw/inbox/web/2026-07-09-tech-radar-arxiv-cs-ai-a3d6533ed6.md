---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.06223"
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

# Information Gain-based Rollout Policy Optimization: An Adaptive Tree-Structured Rollout Approach for Multi-Turn LLM Agents

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.06223
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, ai, llm, model

## 自动摘要

arXiv:2607.06223v1 Announce Type: new Abstract: Reinforcement learning has become a promising paradigm for improving large language model (LLM) agents on long-horizon search tasks, where the agent must make a sequence of intermediate decisions before receiving a final outcome. However, existing methods still face a key limitation: the rollout budget is often allocated without explicitly assessing the utility of intermediate states. As a result, substantial computation may be spent on low-value states, even though different branches can vary drastically in their informativeness. In this paper, we propose Information Gain-based Rollout Policy Optimization (IGRPO), a policy optimization framework that treats intermediate-state informativeness as the organizing principle of rollout collection. Specifically, IGRPO performs budget-aware tree-structured rollouts by allocating expansion budget according to node-level informativeness, so that more informative branches are expanded more frequently while unpromising branches are progressively suppressed. We further demonstrate that the information gain-based rollout induces an explicit limiting teacher distribution over trajectories, which na


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
