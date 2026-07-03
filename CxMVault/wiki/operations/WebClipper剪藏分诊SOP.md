---
type: operation
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - raw/inbox/ideas/注册土耳其及其他低价区 Apple ID 订阅 ChatGPT Plus 教程.md
  - templates/Web Clipper - CxMVault General.json
  - wiki/operations/采集消化复盘SOP.md
confidence: EXTRACTED
tags:
  - sop
  - web-clipper
  - inbox
  - triage
---

# Web Clipper 剪藏分诊 SOP

## 目标

把 Obsidian Web Clipper 保存的网页先作为 raw source 保留，再通过每日消化判断是否进入 wiki。剪藏不是直接变成长期知识，必须先分诊。

## 推荐保存位置

- 普通网页、博客、知乎、公众号：`raw/inbox/web/`
- 长文、研究资料、PDF 摘录：`raw/inbox/articles/`
- 截图和图片：`raw/inbox/screenshots/`
- 只有一个想法或待判断主题：`raw/inbox/ideas/`

Web Clipper 默认模板应保存到 `raw/inbox/web/`，文件名使用 `{{date}}-{{domain}}-{{title}}`，方便按日期清理。

## 每条剪藏的分诊字段

- `processing_status`：`inbox`、`compiled`、`review`、`archived`、`discarded`
- `risk_level`：`low`、`medium`、`high`
- `compile_decision`：`compile`、`reference-only`、`weekly-review`、`discard`
- `source_url`：原始网页链接
- `source_domain`：来源域名
- `created`：剪藏日期

## 分诊流程

1. 先看来源、标题、发布时间和保存原因
2. 判断内容类型：教程、观点、资料、价格信息、项目经验、错误案例或个人想法
3. 判断风险级别：是否涉及账号、支付、绕过区域限制、敏感凭据、平台规则或法律合规
4. 判断编译方式：
   - 可长期复用的概念、原则、决策和排错经验，编译到 `wiki/`
   - 时效性强的价格、链接、促销和网页状态，只保留 raw source 或放入周复盘
   - 涉及平台规则规避、支付风险、账号风控的内容，不编译成操作 SOP，只提炼风险和决策
5. 更新当天 `reviews/daily/YYYY-MM-DD.md`
6. 如产生稳定规则，更新 `wiki/index.md` 和 `wiki/log.md`

## 高风险剪藏处理规则

以下内容默认 `risk_level: high`：

- 跨区订阅、低价区套利、礼品卡充值和平台区域切换
- 账号注册、身份资料、地址生成、支付通道和风控绕过
- 代理、Cookie、Token、Authorization、私钥和测试账号
- 明确可能违反平台服务条款或导致账号封禁的操作

处理方式：

- 原文保留在 `raw/`，不要改写为可执行教程
- wiki 只记录“风险、判断、适用边界、是否值得继续关注”
- 不保存礼品卡代码、账号密码、完整支付信息、Cookie 或私密截图
- 对价格、地区、订阅可用性标记为 `UNVERIFIED` 或 `AMBIGUOUS`，因为这些信息高度时效性

## 健康检查规则

`raw/inbox/` 中的网页剪藏可能包含外站作者名、站内链接或正文里的双方括号链接文本，这些不一定是本 vault 的知识链接。健康检查不应因为 raw source 中的任意 wikilink 失败。

要求：

- `wiki/`、`reviews/`、`templates/` 中的 wikilink 必须可解析
- `raw/inbox/` 中的 wikilink 只作为原文内容保留，不参与断链失败判定
- 如果某个外部作者、网站或资料源需要长期追踪，再单独创建来源页或作者页

## 本次试运行结论

2026-07-02 的 Web Clipper 剪藏保存到了 `raw/inbox/ideas/`，内容是跨区 Apple ID 订阅 ChatGPT Plus 教程。

处理结论：

- 原文作为 raw source 保留
- 不编译成订阅操作教程
- 仅沉淀剪藏分诊规则和风险处理方式
- 后续 Web Clipper 默认模板应改为保存到 `raw/inbox/web/`

