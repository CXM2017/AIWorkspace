---
type: web-capture
status: active
created: 2026-07-13
updated: 2026-07-13
source_refs:
  - "https://simonwillison.net/2026/Jul/12/shot-scraper/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-12T23:46:52+00:00"
processing_status: inbox
risk_level: unreviewed
compile_decision: unreviewed
confidence: UNVERIFIED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# shot-scraper 1.11

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/12/shot-scraper/#atom-everything
- 发布时间：2026-07-12T23:46:52+00:00
- 采集分数：9
- 命中关键词：ai, java

## 自动摘要

Release: shot-scraper 1.11 Some minor improvements, mainly around command option consistency and making the server: mechanism used by both shot-scraper video and shot-scraper multi work if the server takes longer than a second to start serving traffic. server: processes used by shot-scraper multi and shot-scraper video now wait up to 30 seconds for the target URL to accept connections, polling for port availability and replacing the previous fixed one-second delay. #197 The shot-scraper , pdf , html , accessibility and har commands now have a --js-file option for loading JavaScript from a local file, standard input or gh:username/script , as an alternative to --javascript which accepts the string of JavaScript directly as an argument. #192 shot-scraper multi supports the equivalent js_file: YAML key. The shot-scraper javascript and shot-scraper html commands now have a --timeout option for consistency with other commands. #118 Tags: shot-scraper


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
