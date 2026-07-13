---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05794"
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

# From Passive Retrieval to Active Memory Navigation: Learning to Use Memory as a Structured Action Space

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.05794
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, ai, model, evaluation, rag, tools

## 自动摘要

arXiv:2607.05794v1 Announce Type: new Abstract: Long-term user memory is essential for personalized conversational agents, yet many memory systems still expose memory through passive retrieval interfaces, making the model a consumer of pre-selected evidence. We introduce NapMem, a framework for learning to use long-term user memory as a structured action space rather than passively retrieved context. NapMem organizes user history into a linked multi-granularity memory pyramid, where raw conversations, typed memory records, topic tracks, and user profiles are connected through provenance relations, and exposes these levels through memory tools. The agent is trained to select memory according to the query and intermediate evidence, allowing it to inspect different memory granularities before answering. Experiments on PersonaMem-v2, LongMemEval, and LoCoMo show that a NapMem agent trained with memory-tool reinforcement learning is competitive across diverse memory-intensive tasks, while evaluations on non-memory tasks suggest that the learned policy largely preserves general reasoning and tool-use abilities. Additional analyses examine storage, inference cost, tool-use behavior, and a


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
