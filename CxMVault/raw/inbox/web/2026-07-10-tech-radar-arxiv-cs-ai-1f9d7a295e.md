---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07405"
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

# Reason Less, Verify More: Deterministic Gates Recover a Silent Policy-Violation Failure Mode in Tool-Using LLM Agents

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.07405
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：16
- 命中关键词：agent, agents, ai, llm, benchmark

## 自动摘要

arXiv:2607.07405v1 Announce Type: new Abstract: Tool-using LLM agents can violate the very policies they are deployed to enforce while appearing to complete the task successfully. In policy-permissive environments, a tool may execute any well-formed call even when the corresponding state transition is forbidden by domain policy. The result is a silent wrong state (a booking cancelled, a passenger count changed, a claim acted on without verification) that neither the tool nor the agent's self-report exposes. We study this failure mode in the $\tau^2$-bench airline domain. On a budget agent, 78% of observed failures are silent wrong-state failures with no tool error, and the aggregate failure rate is reproducible across disjoint seeds, not sampling noise. We then evaluate a lightweight intervention: deterministic, read-only pre-execution gates that inspect the proposed call and current state before allowing a write. A four-gate suite raises full-benchmark success from 29.6% to 42.0% on gpt-4o-mini (+12.4pp; paired task-level bootstrap P=0.0012), and the lift reproduces on a disjoint 15-seed set (+12.3pp; P=0.0008). The effect is concentrated where the gates fire: on the 26/50 firing 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
