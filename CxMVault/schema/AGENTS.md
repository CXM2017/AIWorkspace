---
type: agent-contract
status: active
created: 2026-07-02
updated: 2026-07-29
source_refs:
  - 00-开始使用.md
  - schema/projects.yaml
  - wiki/operations/采集消化复盘SOP.md
  - wiki/operations/自动化维护流程.md
confidence: EXTRACTED
tags:
  - agents
  - schema
  - llm-wiki
---

# CxMVault Agent 契约

## 目标

维护 `E:\AIWorkspace\CxMVault` 这个跨项目、跨对话、跨 Agent 可读取的长期知识库。`raw/` 保存可追溯来源，`wiki/` 保存编译后的知识，`schema/` 保存治理契约和项目路由。

## 目录职责

- `raw/`：原始资料与 legacy source；已有来源默认不可变
- `raw/inbox/`：待分诊资料，不是长期堆积区
- `wiki/`：经过编译、可复用、可追溯的知识
- `wiki/projects/`：项目长期定义、状态、Runbook 与复用入口
- `wiki/operations/`：跨项目人工流程与运行手册
- `reviews/`：daily、weekly、monthly 复盘证据
- `schema/projects.yaml`：项目身份、路径和能力路由的唯一登记册
- `views/`：Obsidian Bases 视图，只读取页面 frontmatter
- `logs/`、`outputs/`、`tools/`：运行记录、报告与验证工具

## 事实域权威

| 事实域 | 权威来源 |
| --- | --- |
| 用户当前需求 | 用户本轮明确要求 |
| 项目治理 | 距离工作目录最近的项目 `AGENTS.md` |
| 当前代码与构建 | 当前仓库文件、脚本和测试配置 |
| 运行时配置 | 目标远端 Nacos namespace/group/dataId 当前内容 |
| 项目身份与能力路由 | `schema/projects.yaml` |
| 长期项目知识 | `wiki/projects/<project>.md` |
| 重复排错经验 | 对应项目 agentMemory MCP |
| 跨项目固定流程 | `wiki/operations/` 或 Skill |
| 历史来源 | `raw/legacy/`，仅作证据 |

低层来源不得覆盖高层事实：项目页不能替代当前仓库，仓库模板不能替代远端当前配置，旧库不能覆盖已验证的新库结论。

## 项目与对话入口

1. 先确认当前工作目录和项目身份
2. 读取最近作用域的 `AGENTS.md`
3. 用 `schema/projects.yaml` 路由项目页、agentMemory、CodeGraph、数据库 MCP 与配置来源
4. 非简单项目任务再按关键词检索项目页和对应 agentMemory
5. 只有命中任务需要时才加载 Skill、MCP 或插件；不因“已安装”而默认调用
6. 未登记项目可继续依据当前仓库工作，但不得虚构项目页、记忆或配置中心事实；需要长期治理时再登记

固定启动流程使用 `project-bootstrap` Skill；项目能力、规则或配置状态漂移检查使用 `project-doctor` Skill。

## Nacos 配置中心

- 目标远端 Nacos namespace/group/dataId 的当前内容是运行时配置最新事实源
- 仓库 `application.yml`、`bootstrap.yml`、示例配置和 CxMVault 记录只用于定位、启动基线或历史证据；客户端 snapshot/cache 只用于离线取证和恢复
- 默认只读：先解析 profile、server、namespace、group、dataId，再读取远端当前内容，并记录读取时间、来源及脱敏差异或哈希
- 本库不得保存远端完整配置正文、连接串、密码、Token 或其他凭据
- 发布、初始化、导入或覆盖必须由用户对精确目标单独授权；写入前先导出现有配置、核对来源、检查跨项目残留并准备回滚
- 怀疑误覆盖时立即停止写入，优先从 Nacos 历史、服务端存储、客户端 snapshot/cache 或备份恢复

## 知识工作流

人工分诊、状态字段和闭环标准以 [[../wiki/operations/采集消化复盘SOP|采集消化复盘 SOP]] 为准；运行时间、runner、状态文件和通知策略以 [[../wiki/operations/自动化维护流程|自动化维护流程]] 为准。

查询顺序：

1. `wiki/index.md`
2. `schema/projects.yaml` 与目标项目页
3. 必要的 raw source、当前仓库和项目 agentMemory
4. 回答时区分已验证事实、推断与待确认项

## 页面契约

普通 wiki 页面至少包含：

```yaml
---
type: page-type
status: draft | active | deprecated
created: YYYY-MM-DD
updated: YYYY-MM-DD
source_refs:
  - raw/path-or-external-source
confidence: EXTRACTED | INFERRED | AMBIGUOUS | UNVERIFIED
tags:
  - tag
---
```

`type: project` 页面还必须镜像 `schema/projects.yaml` 声明的九个项目字段；健康检查负责发现漂移。

## 验证与安全

- 修改 Vault 后运行 `E:\AIWorkspace\CxMVault\tools\Test-CxMVault.ps1`；只读预检使用 `-NoWrite`
- 不记录密钥、Token、密码、私钥、Cookie、Authorization、测试账号、完整连接串或完整敏感请求体
- 对疑似敏感信息只报告风险，不复制到 wiki、日志、记忆或截图说明
- 旧 `CodeXKnowledge` 与 agentMemory 历史内容默认只读，不删除、不搬空、不静默覆盖
- Obsidian workspace、recent files 与 Agent 会话状态属于 UI 状态，不作为知识事实
