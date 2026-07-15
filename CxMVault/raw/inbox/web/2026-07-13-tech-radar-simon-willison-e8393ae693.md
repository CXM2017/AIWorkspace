---
type: web-capture
status: active
created: 2026-07-13
updated: 2026-07-13
source_refs:
  - "https://simonwillison.net/2026/Jul/6/hy3/#atom-everything"
source_feed: "https://simonwillison.net/atom/everything/"
source_name: "Simon Willison"
source_type: "web"
published_at: "2026-07-06T23:57:35+00:00"
processing_status: archived
risk_level: low
compile_decision: reference-only
confidence: EXTRACTED
tags:
  - ai
  - devtools
  - inbox
  - llm
  - tech-radar
---

# tencent/Hy3

## 来源

- 来源：Simon Willison
- 原文：https://simonwillison.net/2026/Jul/6/hy3/#atom-everything
- 发布时间：2026-07-06T23:57:35+00:00
- 采集分数：9
- 命中关键词：ai, llm, model, productivity

## 自动摘要

tencent/Hy3 New Apache 2.0 licensed model from Tencent in China: Hy3 is a 295B-parameter Mixture-of-Experts (MoE) model with 21B active parameters and 3.8B MTP layer parameters, developed by the Tencent Hy Team. Following the Hy3 Preview launch in late April, we gathered feedback from 50+ products and scaled up post-training with higher quality data. Today, we introduce Hy3, which outperforms similar-size models and rivals flagship open-source models with 2-5x parameters. It also shows significant gains in utility across various products and productivity tasks. The full-sized model is 598GB on Hugging Face, and the FP8 quantized one is 300GB . The context length is 256K. It's available for free on OpenRouter until July 21st . I had it "Generate an SVG of a pelican riding a bicycle" there and got this: Update : I'd forgotten about this but Max Woolf wrote about an earlier preview of this model back on May 26th: The mysterious Hy3 LLM is topping OpenRouter Model Rankings by a large margin . When I tried that one I got back this pelican which wasn't as good as today's but did have a "Change Pelican Color" button, a first from any model. Tags: ai , generative-ai , llms , pelican-riding


## 后续处理建议

- 先判断是否和当前 Java/Spring、AI agent、MCP、Skills、开发工具、知识管理、自动化或安全实践有关
- 有长期价值再编译到 `wiki/`，否则标记为 reference-only 或 discarded
