---
type: web-capture
status: active
created: 2026-07-13
updated: 2026-07-13
source_refs:
  - "https://simonwillison.net/2026/Jul/3/judgement/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-03T18:51:06+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: EXTRACTED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# Fable's judgement

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/3/judgement/#atom-everything
- 发布时间：2026-07-03T18:51:06+00:00
- 采集分数：12
- 命中关键词：agent, agents, ai, model, claude, coding

## 自动摘要

One of the most interesting tips I got from the Fireside Chat I hosted with Cat Wu and Thariq Shihipar from the Claude Code team at AIE on Wednesday was to let Fable (and to a certain extent Opus) use their own judgement rather than dictating how they should work. The example they gave was testing. You can tell Fable "only use automated testing for larger features, don't update and run tests for small copy or design changes" - but it's better to just tell Fable to use its own judgement when deciding to write tests instead. Jesse Vincent just gave me a related tip to help avoid burning too many of those valuable Fable tokens in the few days we have left before the prices go up. Tell Fable to use other models for smaller tasks, applying its own judgement about which model to use. I prompted Claude Code just now with: For all coding tasks use your judgement to decide an appropriate lower power model and run that in a subagent Claude saved this memory file in ~/.claude/projects/name-of-project/memory/delegate-coding-to-subagents.md : --- name: delegate-coding-to-subagents description: Simon wants coding tasks delegated to subagents running an appropriately lower-power model metadata: n


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
