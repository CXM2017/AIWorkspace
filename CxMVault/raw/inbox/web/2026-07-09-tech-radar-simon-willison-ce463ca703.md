---
type: web-capture
status: active
created: 2026-07-09
updated: 2026-07-09
source_refs:
  - "https://simonwillison.net/2026/Jul/2/llm-coding-agent/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-02T19:33:12+00:00"
processing_status: compiled
risk_level: low
compile_decision: compile
confidence: INFERRED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# llm-coding-agent 0.1a0

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/2/llm-coding-agent/#atom-everything
- 发布时间：2026-07-02T19:33:12+00:00
- 采集分数：16
- 命中关键词：agent, ai, llm, openai, claude, coding, github, repository, tools

## 自动摘要

Release: llm-coding-agent 0.1a0 Another Fable 5 experiment. Now that my LLM library has evolved into more of an agent framework it's time to see what a simple coding agent would look like built on it. I started a new Python library using my python-lib-template-repository GitHub template repository, then ran these two prompts (here's the Claude Code for web transcript ): Write a spec.md for this project - it will depend on the latest “llm” alpha from PyPI and implement a Claude code style coding agent complete with tools for reading and editing files and executing commands Then: Commit the spec, then build it using red/green TDD in a series of sensible commits (each with passing tests and updated docs) - occasionally manually test it using the OpenAI API key in your environment Here's the spec , the resulting README file , and the sequence of commits . I've shipped a slop-alpha to PyPI, so you can run the new agent like this: uvx --prerelease=allow --with llm-coding-agent llm code It's pretty good for a first attempt! Here's the (Fable-authored) README , which lists recipes like llm code --yolo and llm code --allow "pytest*" --allow "git diff*" . It also presents a Python API based 


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
