---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://arxiv.org/abs/2607.05772"
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

# Detecting Vulnerability-Inducing Commits via Multi-Stage Reasoning with LLM-Based Agents

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.05772
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：17
- 命中关键词：agent, agents, ai, llm, security, rag

## 自动摘要

arXiv:2607.05772v1 Announce Type: new Abstract: Detecting vulnerability-inducing commits (VICs) at submission time is critical for improving the security and reliability of software systems. However, this task is highly challenging because it requires reasoning about the semantic impact of code changes from heterogeneous information sources, including code diffs, commit messages, and the surrounding contextual code. Existing approaches often struggle to fully capture these complex interactions, resulting in limited detection performance. In this paper, we propose VIC-RAGENT, an LLM-based multi-agent framework for effective and explainable vulnerability detection. VIC-RAGENT leverages multiple specialized agents to provide complementary perspectives, including structural analysis, intent understanding, and vulnerability inspection. To further improve detection reliability, the framework employs a multi-stage reasoning process that progressively refines candidate vulnerabilities through preliminary inspection, reanalysis, and a final decision stage. Experimental results on a real-world dataset across multiple LLMs demonstrate that VIC-RAGENT consistently outperforms baselines, includ


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
