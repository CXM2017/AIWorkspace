---
type: inbox-guide
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - wiki/operations/采集消化复盘SOP.md
confidence: EXTRACTED
tags:
  - inbox
  - capture
---

# raw/inbox

这里是所有新资料的临时入口。不要在这里长期堆东西；每天消化，每周复盘。

## 子目录

- `web/`：网页、博客、知乎、公众号、网页剪藏
- `articles/`：长文章、PDF 摘录、研究资料
- `screenshots/`：截图、报错图、界面图
- `files/`：本地文件、附件、导出包
- `ideas/`：临时想法、未判断归属的信息

## 状态规则

每条资料消化后只保留以下状态之一：

- 已编译：对应 wiki 页面已创建或更新
- 待复盘：信息有价值但还不够稳定
- 已归档：作为 raw source 保留，不进入 wiki
- 已丢弃：无长期价值，可人工确认后删除

## Web Clipper

Obsidian Web Clipper 推荐导入 `templates/Web Clipper - CxMVault General.json`。

默认保存到：`raw/inbox/web/`

如果剪藏内容涉及跨区订阅、账号风控、支付、代理、凭据或平台规则风险，只保留 raw source，不编译成可执行操作教程；只提炼风险、判断和后续复盘结论。

