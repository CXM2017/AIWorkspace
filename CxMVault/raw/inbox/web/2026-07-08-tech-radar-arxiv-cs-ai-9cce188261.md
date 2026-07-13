---
type: web-capture
status: active
created: 2026-07-08
updated: 2026-07-08
source_refs:
  - "https://arxiv.org/abs/2607.05750"
source_feed: "https://rss.arxiv.org/rss/cs.AI"
source_name: "arXiv cs.AI"
source_type: "web"
published_at: "2026-07-08T04:00:00+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: UNVERIFIED
tags:
  - ai
  - inbox
  - paper
  - tech-radar
---

# ArtisanCAD: An Industrial-Level CAD Agent with Expert-Grounded Knowledge Distillation

## 来源

- 来源：arXiv cs.AI
- 原文：https://arxiv.org/abs/2607.05750
- 发布时间：2026-07-08T04:00:00+00:00
- 采集分数：17
- 命中关键词：agent, ai, model, mcp, workflow, knowledge, skill, skills

## 自动摘要

arXiv:2607.05750v1 Announce Type: new Abstract: Computer-aided design (CAD) for industrial components requires long-horizon procedural modeling, robust feature dependencies, editable parametric geometry, and production-grade B-Rep execution. Existing text-to-CAD methods have made promising progress in generating CAD programs from natural-language descriptions, but they still struggle when user prompts are ambiguous, underspecified, or only describe high-level design intent. They also rarely exploit expert procedural knowledge naturally available in industrial workflows, such as CATIA operation recordings, macro logs, drawing notes, and engineering descriptions. We present \algname, a skill-guided industrial CAD agent with expert-grounded knowledge distillation. The core of \algname is CAD intermediate representation (CAD-IR), an executable procedural representation that encodes parameters, ordered operations, MCP tool bindings, dependencies, generated entities, and verification rules. CAD-IR plays two key roles: it first serves as the carrier for distilling expert CAD procedures into reusable parameterized skills; then it provides a procedural scaffold that turns vague or intermedi


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
