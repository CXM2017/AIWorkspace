---
type: maintenance-log
status: active
created: 2026-07-02
updated: 2026-07-29
source_refs:
  - tools/Initialize-CxMVault.ps1
  - tools/Test-CxMVault.ps1
confidence: EXTRACTED
tags:
  - log
  - maintenance
---

# 维护日志

## [2026-07-29] agentmemory-mcp-path-normalization | 项目记忆 MCP 路径统一

- 以 `agentmemory_steeltechnologynode_api` 的已验证配置为基线，统一 16 个 MCP 的项目存储根、进程临时目录和 npm 缓存目录
- 修复 CRRC_API、CRRC_VUE_Index、CRRC_VUE_admin 与 SinopecNode_api 的环境变量偏差；配置修改前已备份 `D:\CodeX\.codex\config.toml` 并校验备份一致性
- 对全部服务执行配置审计与 JSON-RPC `initialize` 握手，结果为 16/16 通过；未写入凭据、验证码或 Token

## [2026-07-29] sinopecnode-portal-runbook-refresh | 门户路由与登录验证防回归

- 更新 [[projects/SinopecNode_api|SinopecNode_api]]，将已失效的 `/system/news/**` Runbook 路由替换为当前 `/portal/**`、`/portal/admin/**` 与公开文件路径
- 新增 [[../reviews/daily/2026-07-29|2026-07-29 日记录]]，固定本地登录页入口、无凭据检查与登录后受保护接口回归顺序
- 注册 `agentmemory_sinopecnode_api` 并写入首条门户回归 Runbook；当前会话未刷新时以 CxMVault 项目页为强制回退入口，并在根 AGENTS 约束启动前检索与路由变更后的同步更新
- 未写入 Client ID、凭据、验证码、Token 或完整认证响应

## [2026-07-28] sinopecnode-portal-news-regression | 门户资讯管理本地闭环

- 更新 [[projects/SinopecNode_api|SinopecNode_api]]，新增从 SQL/Nacos/服务重启到功能验收的固定 Runbook
- 新增 [[../reviews/daily/2026-07-28|2026-07-28 日记录]]
- 记录 `portal_news` 未落库、网关路由、Redis 验证码、会话冻结、RepeatSubmit、封面浏览器缓存与统一业务码判断
- 真实网关回归确认临时封面释放、草稿/发布/下架/删除与删除后文件不可读取全部通过
- 未写入任何测试凭据、验证码、Token 或认证响应

## [2026-07-24] weekly-review | 2026-W30 周回顾（截至本周四）

- 新增 [[../reviews/weekly/2026-W30|2026-W30 周复盘]] 和 `reviews/daily/2026-07-24.md`
- 汇总 CRRC 动态数据集后端闭环、三端契约与前端联调前置条件；明确后端完成不等于全链路业务闭环
- 汇总 [[projects/SinopecNode_api|SinopecNode_api]] 的 portal 独立服务初始化、边界和构建基线
- 既有 6 条 Skills / Skills 市场候选仍保持 `review` / `weekly-review`，未安装、未生成操作流程

## [2026-07-21] crrc-vue-index-onboarding | CRRC_VUE_Index 项目初始化

- 新增 [[projects/CRRC_VUE_Index|CRRC_VUE_Index]] 项目页，记录 Vue 前端结构、代理、认证与 CRRC_API 联调边界
- 已初始化前端 CodeGraph：87 文件、1,881 节点、4,530 条关系；根 `.gitignore` 忽略 `.codegraph/`
- 新增前端本地 `AGENTS.md`，将路由、API 封装、Pinia 状态、分页与后端契约收敛为可复用规则
- 本地启动联调修正代理至 Admin `35698/crrc`，修复失效的 Element Plus 预发布依赖和缺失 terser；构建与浏览器访问均已通过

## [2026-07-17] weekly-review | 2026-W29 周回顾

- 新增 [[../reviews/weekly/2026-W29|2026-W29 周复盘]] 和 `reviews/daily/2026-07-17.md`
- 汇总 Chrome Native Host 自动修复收敛、CRRC_API 项目接入和技术雷达消化；重复主题已链接到既有 runbook、项目页和领域页
- 6 条 Skills / Skills 市场候选保留为 `review` / `weekly-review`，在完成来源、能力与安全评估前不安装、不编译为操作流程

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

## [2026-07-13] tech-radar-ingest | 技术雷达消化

- 消化 20 条 `raw/inbox/web/2026-07-13-tech-radar-*.md` 候选
- 更新 [[domains/AI Agent工程与工具生态雷达|AI Agent 工程与工具生态雷达]]：补充 coding agent 证据链、真实评测、agent 平台基础设施、责任边界和运行成本观察
- 新增 `reviews/daily/2026-07-13.md`，记录本次编译、reference-only、高风险和周复盘判断
- 12 条内容标记为 `compiled`，7 条内容标记为 `reference-only`，1 条星标异常且涉及逆向工具边界的项目进入周复盘
- offensive-security harness 和定位篡改工具只保留风险结论，未编译成可执行攻击、规避或篡改 SOP
- 未写入旧 `E:\CodeXData\CodeXKnowledge` 或 `E:\CodeXData\agentMemory`

## [2026-07-16] codex-chrome-native-host-auto-repair | Codex Chrome 扩展永久化修复

- 更新 [[operations/Codex Chrome扩展NativeHost修复|Codex Chrome 扩展 Native Host 修复]]
- 新增固定修复入口：`D:\CodeX\maintenance\Repair-CodexChromeNativeHost.ps1`
- 新增定时自愈注册入口：`D:\CodeX\maintenance\Register-CodexChromeNativeHostRepairTask.ps1`
- 根因更新：桌面端从 2026-07-10 的 AppX 版本升级到 `OpenAI.Codex_26.707.9981.0_x64__2p2nqsd0c76g0` 后，v2 manifest 仍指向旧 AppX 版本和旧 runtime hash
- 结论：后续不再手工写死 manifest 路径，改为脚本检测当前包版本、插件版本和 runtime hash 后自动重建 native host 配置

## [2026-07-16] codex-chrome-native-host-manual-repair | 改为手动一键修复

- 删除每 10 分钟运行的 `CodexChromeNativeHostRepair` 计划任务
- 新增桌面入口：`C:\Users\CxM\Desktop\修复 ChatGPT Chrome 扩展.cmd`
- `Register-CodexChromeNativeHostRepairTask.ps1` 改为可选的登录时一次检查；`-Mode Remove` 用于移除该任务
- 默认策略：桌面端升级后仅在 Chrome 侧边栏报错时手动执行，避免无意义后台轮询

## [2026-07-16] crrc-api-onboarding | CRRC_API 项目初始化

- 新增 [[projects/CRRC_API|CRRC_API]] 项目页，记录模块边界、认证与数据访问链路、测试入口和安全边界
- 已初始化 CodeGraph，索引 675 文件、15,316 节点、23,882 关系
- 已建立本地 `AGENTS.md` 与项目说明，测试账号仅写入仓库外私有文件
- agentMemory 使用 `agentmemory_crrc_api`，数据库 MCP `crrc_test_mysql` 已注册并由服务端强制只读 SQL

## [2026-07-21] crrc-three-repo-governance | 中车三个仓库治理与动态字段改造复核

- 更新 [[projects/CRRC_API|CRRC_API]] 与 [[projects/CRRC_VUE_Index|CRRC_VUE_Index]]，新增 [[projects/CRRC_VUE_admin|CRRC_VUE_admin]]
- 记录门户、后台管理、Admin/Custom 本地联调入口以及三个仓库的动态字段改造边界
- 确认 API agentMemory 与只读 MySQL MCP 可用；补充两个前端 agentMemory 的存储目录和 MCP 配置，待重启 Codex 后初始化验证
- 将动态字段影响范围从列表展示扩展到详情、查询、导入导出、分析结果和算法输入

## [2026-07-22] crrc-dynamic-dataset-backend | 中车动态数据集后端闭环

- 更新 [[projects/CRRC_API|CRRC_API]]、[[projects/CRRC_VUE_admin|CRRC_VUE_admin]] 与 [[projects/CRRC_VUE_Index|CRRC_VUE_Index]] 的跨端契约
- 后端完成动态CRUD、新表、字段归档删除、导入导出、分析和现有算法稳定字段映射；Base 61项测试及Admin、Custom打包通过
- DDL审计使用独立事务并支持建表、删列的元数据失败恢复；相同操作编号禁止复用于不同请求
- 只读数据库复核发现7个`creater`字段仍需补丁修正，当前有效算法映射为0；以上均列为前端联调和提测前置条件

## [2026-07-23] sinopecnode-api-initialization | 中石化骨干节点后端初始化

- 新增 [[projects/SinopecNode_api|SinopecNode_api]] 项目页并加入 Wiki 索引
- 记录基于 `SteelTechnologyNode_api` 初始化后的 8 个运行服务、6 个数据库和 `sinopecnode-*` Nacos 命名
- portal 已从 system 拆为独立服务，通过 Dubbo 契约访问用户与字典能力
- portal 27 项测试和 Maven 58 模块全量打包通过；敏感配置字面量与旧项目标识残留审计均为 0

## [2026-07-29] codex-governance-registry | 项目、对话与知识治理收敛

- 新增 `schema/projects.yaml`，统一登记 7 个当前项目的身份、路径、知识层级、agentMemory、CodeGraph、数据库 MCP 与配置权威
- 新增 Project Registry 与 Inbox Review 两个 Obsidian Base；项目页镜像九个治理字段，由健康检查发现登记漂移
- 将 SteelTechnologyNode_api 与 MyExcel 从旧库桥接页升级为事实化项目页，并为 MyExcel 增加工作区级 `AGENTS.md`
- 将 Nacos 纳入一等治理：远端当前内容为运行事实源，仓库模板仅作定位和对照，snapshot 仅作恢复；默认只读，写入需单独授权、远端导出与回滚源
- 新增 `project-bootstrap` 与 `project-doctor` Skill 暂存实现，用于新项目/新对话装载和项目能力漂移诊断
- 关闭 CRRC 三个 agentMemory 的“待重启验证”旧状态，记录 2026-07-29 JSON-RPC initialize 已验证结果
- 修正 Sinopec 门户旧规则强制新会话的问题：Registry 登记 `portal-login-test` 与 session-first 策略，补充最近层级 AGENTS 和 `sinopec-portal-regression` Skill
