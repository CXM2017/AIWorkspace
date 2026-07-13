---
type: web-capture
status: active
created: 2026-07-10
updated: 2026-07-10
source_refs:
  - "https://arxiv.org/abs/2607.07461"
source_feed: "https://rss.arxiv.org/rss/cs.SE"
source_name: "arXiv cs.SE"
source_type: "web"
published_at: "2026-07-09T04:00:00+00:00"
processing_status: compiled
risk_level: medium
compile_decision: compile
confidence: EXTRACTED
tags:
  - inbox
  - paper
  - software-engineering
  - tech-radar
---

# Mitigating Taint-Style Vulnerabilities in MCP Servers via Security-Aware Tool Descriptions

## 来源

- 来源：arXiv cs.SE
- 原文：https://arxiv.org/abs/2607.07461
- 发布时间：2026-07-09T04:00:00+00:00
- 采集分数：22
- 命中关键词：agent, agents, ai, llm, model, security, mcp, protocol, tools

## 自动摘要

arXiv:2607.07461v1 Announce Type: cross Abstract: Large language models (LLMs) are increasingly deployed as autonomous agents that interact with external tools and services via the Model Context Protocol (MCP), a standardized interface for dynamic tool invocation. While MCP simplifies integration, it also expands the attack surface and enables generic exploits across multiple servers. Despite prior work on malicious MCP servers, the vulnerability landscape of MCP servers remains underexplored. In this work, we systematically analyze MCP server vulnerabilities, focusing on metadata characteristics, vulnerable code patterns, and community responses. Our study reveals that taint-style vulnerabilities constitute a substantial fraction of MCP server vulnerabilities, require significant code modifications to remediate, and are met with slow community responses. Motivated by these findings, we propose SPELLSMITH, presenting a novel textbased avenue for shielding taint-style vulnerabilities in MCP servers. In particular, SPELLSMITH analyzes the high-risk capabilities exposed by an MCP server and combines them with tool descriptions and parameter semantics to identify potential taint-style 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
