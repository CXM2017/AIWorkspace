---
type: maintenance-log
status: active
created: 2026-07-02
updated: 2026-07-10
source_refs:
  - tools/Initialize-CxMVault.ps1
  - tools/Test-CxMVault.ps1
confidence: EXTRACTED
tags:
  - log
  - maintenance
---

# 维护日志

## [2026-07-02] initialize | CxMVault 初始化

- 创建 Karpathy LLM Wiki 核心目录：`raw/`、`wiki/`、`schema/`、`logs/`、`outputs/`、`tools/`
- 从旧 `CodeXKnowledge` 白名单迁移 Obsidian 插件、主题和配置
- 重置旧 workspace、recent files、Claudian 会话状态，避免旧 vault 页面污染新库
- 生成旧 `CodeXKnowledge` 来源索引
- 生成 `agentMemory` 旧项目记忆桥接

## [2026-07-02] production-loop | 补齐日常闭环

- 新增 `00-开始使用.md`
- 新增采集、每日消化、每周复盘、每月整理说明
- 新增 inbox、daily、weekly、monthly、wiki 页面模板
- 增强健康检查，加入控制字符检测

## [2026-07-02] retrospective | 沉淀新库搭建流程

- 新增 [[operations/新知识库搭建与验收流程|新知识库搭建与验收 Runbook]]
- 记录本次从计划到落地的标准流程、踩坑和下次执行提示
- 将 PowerShell 反引号退化、Obsidian 状态污染、目录无说明、断链检查缺失列为下次必检项

## [2026-07-02] workspace-agents-bridge | 修正外部工作区入口

- 更新 `D:\CodeX\.codex\AGENTS.md`
- 更新 `E:\CodeXData\AGENTS.md`
- 将 `E:\AIWorkspace\CxMVault` 明确为当前个人主知识库 / Obsidian 主 vault
- 将 `E:\CodeXData\CodeXKnowledge` 降级为旧项目知识库 / legacy source
- 要求 `E:\CodeXData` 项目任务先查 `CxMVault`，不足时再查旧 `CodeXKnowledge` 和 `agentMemory`

## [2026-07-02] skill-entrypoint-bridge | 修正 Skill 入口

- 更新 `vault-maintainer`、`obsidian-vault`、`config-center-startup`、`diary`、`automation-reliability`
- 将日记、自动化 runbook、启动 runbook 和 vault 维护的默认写入位置统一到 `E:\AIWorkspace\CxMVault`
- 旧 `CodeXKnowledge` 只保留为 legacy fallback，用于历史来源追溯或新 vault 未完成编译时补读
- 记录到 [[operations/新知识库搭建与验收流程|新知识库搭建与验收 Runbook]]：下次切换知识库必须同步扫描并修正 Skill 入口

## [2026-07-02] web-clipper-ingest | Web Clipper 剪藏试运行

- 读取 `raw/inbox/ideas/注册土耳其及其他低价区 Apple ID 订阅 ChatGPT Plus 教程.md`
- 判定该剪藏涉及跨区订阅、账号区域、礼品卡和平台规则风险，不编译为可执行教程
- 新增 [[operations/WebClipper剪藏分诊SOP|Web Clipper 剪藏分诊 SOP]]
- 新增 `templates/Web Clipper - CxMVault General.json`，建议后续网页剪藏默认进入 `raw/inbox/web/`
- 更新 `reviews/daily/2026-07-02.md` 记录本次分诊结论

## [2026-07-02] web-clipper-compile | Java 路线文章编译

- 读取 `raw/inbox/web/2026-07-02T135014+0800-51cto.com-2026 之后，Java 程序员还值钱吗？一份真正靠谱的进化路线图-51CTO.COM.md`
- 新增 [[domains/Java现代后端进化路线|Java 现代后端进化路线]]
- 将剪藏 metadata 更新为 `processing_status: compiled`
- 对 JDK 25、Spring Boot 虚拟线程、JUnit 6 等版本判断补充官方来源边界

## [2026-07-02] graph-localization | 图谱中文化

- 将主要 `wiki/operations/` 和 `wiki/domains/` 知识页文件名改为中文
- 新增 [[知识库图谱入口|知识库图谱入口]] 作为图谱中心节点
- 更新 `.obsidian/graph.json`，默认隐藏 `README`、`index`、`log`、`overview` 等低价值维护节点
- 保留 `wiki/index.md` 等机器入口，避免 agent 读取入口失效

## [2026-07-02] automation-maintenance | 定时自学习闭环

- 新增 [[operations/自动化维护流程|自动化维护流程]]
- 新增本地 runner：`D:\CodeX\.codex\automations\cxmvault-maintenance\scripts\run-cxmvault-maintenance.ps1`
- 自动化输出目录：`E:\AIWorkspace\CxMVault\outputs\automation\cxmvault-maintenance\`
- 创建 daily、weekly、monthly 三个 Codex cron 自动化：`cxmvault`、`cxmvault-2`、`cxmvault-3`
- 新增 `reviews/weekly/2026-W27.md` 和 `reviews/monthly/2026-07.md` 作为首轮自动化复盘落点

## [2026-07-03] weekly-maintenance | 每周整理巡检

- 运行 weekly runner：`D:\CodeX\.codex\automations\cxmvault-maintenance\scripts\run-cxmvault-maintenance.ps1`
- 结果：`status=ok`，pending items 为 0，健康检查 `pass`
- 更新 `reviews/weekly/2026-W27.md`，补充自动化巡检、重复主题提升判断和图谱检查结论
- 未写入旧 `E:\CodeXData\CodeXKnowledge` 或 `E:\CodeXData\agentMemory`

## [2026-07-07] tech-radar-ingest | 技术雷达消化

- 消化 40 条 `raw/inbox/web/2026-07-07-tech-radar-*.md` 候选
- 新增 [[domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]]
- 新增 [[operations/CxMVault链接关系体检|CxMVault 链接关系体检]]
- 更新 [[operations/自动化维护流程|自动化维护流程]]、[[domains/Java现代后端进化路线|Java 现代后端进化路线]]、[[index|Wiki 索引]] 和 [[知识库图谱入口|知识库图谱入口]]
- 将高价值 agent/MCP/Skills/Obsidian/Java-Spring 主题编译为领域观察，时效性强的云合作、芯片、模型预告和区域报告保留为 reference-only

## [2026-07-07] tech-radar-top10-email | 技术雷达 Top10 邮件报告

- 扩展 Tech Radar 来源：Product Hunt、Hugging Face Blog、Simon Willison、Latent Space、本机 Codex Skills 和 Codex/Claude Code Skills GitHub 信号
- 新增报告 runner：`D:\CodeX\.codex\automations\cxmvault-tech-radar\scripts\run-cxmvault-tech-radar-report.ps1`
- 生成 HTML/Markdown 报告：`outputs/reports/tech-radar/2026-07-07/`
- 报告策略调整为日常只发 Top10，完整候选池留在本地供复盘
- 已通过 Gmail 发送到个人邮箱，Gmail message id：`19f3a2f7419044f6`

## [2026-07-07] tech-radar-three-lists | 技术雷达三榜修正

- 根据反馈修正报告结构：不再混成 Skills 总榜
- 报告拆成“最新资讯/文章 Top10”“热门项目 Top10”“Skills Top10”
- 修正项目榜分类逻辑：普通热门项目即使命中 skill 关键词，也不归入 Skills 榜
- 已发送修正版 Gmail，Gmail message id：`19f3a3bc09a4753f`

## [2026-07-07] tech-radar-hot-threshold | 技术雷达热点阈值

- 调整为每榜最多 10 条，但只报达到热点阈值的内容；不足 10 条不硬凑
- 三榜均无热点时 `should_send=false`，不发送邮件
- 本机已经安装的 Skills 不再采集、不再上报，只保留外部 Codex/Claude Code Skills 信号

## [2026-07-08] tech-radar-ingest | 技术雷达消化

- 消化 40 条 `raw/inbox/web/2026-07-08-tech-radar-*.md` 候选
- 更新 [[domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]]：补充 agent 评测从静态榜单转向环境化、可审计过程和开发者学习成本的观察
- 更新 [[domains/Java现代后端进化路线|Java 现代后端进化路线]]：将 `apereo/cas` 作为企业认证复杂度参考，后台模板仅保留脚手架参考
- 31 条低风险内容标记为 `compiled`，6 条泛资源或背景内容标记为 `reference-only`，3 条信号异常或采用风险不清的项目进入周复盘
- 安全工具编排相关内容只作为治理和能力边界参考，不编译成可执行攻击 SOP

## [2026-07-09] tech-radar-ingest | 技术雷达消化

- 消化 20 条 `raw/inbox/web/2026-07-09-tech-radar-*.md` 候选
- 更新 [[domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]]：补充 agent 记忆主动导航、review-revise 闭环、可观测性、漏洞诱导提交检测和开发者理解参与的观察
- 15 条低风险高相关内容标记为 `compiled`，4 条泛资源或背景内容标记为 `reference-only`，1 条 Skills 市场信号进入周复盘
- 未写入旧 `E:\CodeXData\CodeXKnowledge` 或 `E:\CodeXData\agentMemory`

## [2026-07-10] codex-chrome-native-host | Codex Chrome 扩展修复沉淀

- 新增 [[operations/Codex Chrome扩展NativeHost修复|Codex Chrome 扩展 Native Host 修复]]
- 记录 Chrome 侧边栏 `codexCliPath` 缺失和 `native host v2 manifest is missing` 的快速排查路径
- 关键结论：不要把整个 `C:\Users\CxM\AppData\Local\OpenAI\Codex` junction 到 `D:\CodeX\.codex`；应保持 `bin` 单独 junction，并修复 bundled 插件源、`latest` junction、标准 native host manifest 与 v2 manifest
- 本次验证结果：Chrome 插件实际连接返回 `ok: true`

## [2026-07-10] tech-radar-ingest | 技术雷达消化

- 消化 20 条 `raw/inbox/web/2026-07-10-tech-radar-*.md` 候选
- 更新 [[domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]]：补充 agent 确定性门禁、技能治理、轨迹级评测、专业领域审计、MCP 安全边界和生产 workflow 固化的观察
- 16 条内容标记为 `compiled`，3 条时效性或双用途内容标记为 `reference-only`，1 条 BYOK 设计工具进入周复盘
- 双用途 PoC 与安全委派内容只保留防御性风险结论，未编译成可执行攻击或规避 SOP
- 未写入旧 `E:\CodeXData\CodeXKnowledge` 或 `E:\CodeXData\agentMemory`

## [2026-07-10] weekly-maintenance | 每周整理巡检

- 运行 weekly runner：`D:\CodeX\.codex\automations\cxmvault-maintenance\scripts\run-cxmvault-maintenance.ps1`
- 结果：`status=ok`，pending items 为 0，健康检查 `pass`
- 新增 `reviews/weekly/2026-W28.md`，汇总本周 Tech Radar、Native Host runbook、重复主题提升判断和图谱检查结论
- 未写入旧 `E:\CodeXData\CodeXKnowledge` 或 `E:\CodeXData\agentMemory`
