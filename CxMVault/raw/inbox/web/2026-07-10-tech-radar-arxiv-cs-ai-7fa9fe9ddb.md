---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07436"
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

# The Blind Curator: How a Biased Judge Silently Disables Skill Retirement in Self-Evolving Agents

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.07436
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：17
- 命中关键词：agent, agents, ai, llm, skill, skills

## 自动摘要

arXiv:2607.07436v1 Announce Type: new Abstract: A self-evolving agent retires its bad skills by watching them fail, so what happens when the judge cannot see the failures? Skill retirement is the structural constraint that keeps a growing library from drifting below the no-skill baseline, but its guarantee assumes an unbiased reward, which is false for the LLM judges that reference-free tasks force upon us. We show that a biased judge does not merely add noise; it \emph{silently switches off the curator}. We make this precise with a corrupted-reward analysis and, isolating the causal channel by injecting corruption on top of a deterministic reward, a behavioral study on a reference-free report-writing testbed with a code-generation cross-check. Symmetric noise leaves retirement intact, but \emph{false-pass} bias (failures slipping through as passes) disables contribution-based retirement past a sharp threshold that no amount of data can cross. Separating genuine retirement from cap-eviction churn shows this \emph{mechanism} failure is universal, holding across domains and failure rates and sparing only near-zero-false-pass, verifier-like graders. The downstream \emph{outcome}, thou


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
