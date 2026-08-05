---
type: operation
status: active
created: 2026-07-29
updated: 2026-07-29
source_refs:
  - schema/projects.yaml
  - schema/AGENTS.md
  - D:\CodeX\.codex\skills\project-bootstrap\SKILL.md
  - D:\CodeX\.codex\skills\project-doctor\SKILL.md
confidence: EXTRACTED
tags:
  - codex
  - governance
  - project
  - conversation
---

# Codex 工作台治理

## 分层

| 层 | 只负责 |
| --- | --- |
| 全局 `D:\CodeX\.codex\AGENTS.md` | 跨项目长期安全边界和路由条件 |
| 项目/嵌套 `AGENTS.md` | 当前仓库真实结构、命令、代码锚点、配置定位和例外 |
| `schema/projects.yaml` | 项目身份、路径、能力与知识入口 |
| 项目页 | 长期状态、Runbook、已验证结论和历史决策 |
| agentMemory | 可复用的项目级根因、命令和验证结果 |
| Skill | 可重复的确定流程、脚本、模板和检查清单 |
| Plugin/MCP | 只有任务需要的外部能力与事实读取 |
| Codex 任务历史 | 一次执行证据；不是长期规则的唯一存放处 |

同一规则只保留一个权威正文，其他位置使用链接或“何时读取”的短路由。

## 新项目或新任务

1. 使用 `project-bootstrap` 确认路径、最近 AGENTS、Registry、项目页与项目记忆
2. 只加载当前任务需要的 Skill、CodeGraph、MCP 或插件
3. 未登记项目先按仓库事实工作，不虚构 Registry、项目页或记忆；确认长期维护后再登记
4. Registry 或项目页疑似漂移时运行 `project-doctor`，不在业务改动中顺手大规模修复治理文件

## 插件和 MCP

- “已安装”不等于“每次启用”；按任务能力选择，避免启动无关认证和外部访问
- 当前未安装的 Atlassian、Box、Calendar、Notion、SharePoint、Teams 等连接器不因治理工作自动安装
- 只有用户任务明确需要对应外部系统，且本地 Skill/MCP/现有插件无法完成时，才提出连接或安装
- 项目记忆优先使用 Registry 映射的 `agentmemory_*`；数据库 MCP 默认按登记权限使用
- 插件、MCP、Skill 的重复项以“能力是否等价、是否仍有项目依赖、最后成功验证时间”判断，不按目录名直接删除

## Nacos 项目

- 远端当前 namespace/group/dataId 是运行事实源
- 仓库模板用于定位、初始化与差异对照，客户端 snapshot/cache 用于恢复
- 普通启动与诊断只授权读取；发布、导入、初始化、覆盖或回滚需要精确目标的单独授权
- 写入前必须导出现有远端内容、核对来源和跨项目残留、生成脱敏差异并准备回滚
- 自动化和项目引导不得执行 Nacos 写操作

## 历史任务

- 成功完成、无待处理动作的自动化运行和一次性诊断任务可以归档
- 当前任务、置顶任务、失败任务、等待用户输入、待发送或需要复查的任务不得归档
- 归档使用 Codex 的可恢复归档能力，不删除 session 文件或直接改内部数据库
- 长期有价值的结论必须先进入项目页、operation、Skill 或项目记忆，再归档原任务

## 清理与归档

按“盘点 → 归属 → 备份/可恢复归档 → 验证 → 删除”执行：

1. 活跃配置、当前插件版本、业务文件、凭据、浏览器数据和用途不明目录只报告
2. session 历史优先用任务归档，不直接删除
3. 插件安装残留、临时目录和旧备份先证明没有当前引用，再移动到带日期的隔离区
4. 隔离期后仍要永久删除时，必须再次确认精确目标
5. 每次清理记录前后数量、大小、路径、恢复方式和验证结果

## 收尾

- 业务修改按风险运行最小验证
- 新的稳定根因、启动/联调流程或重大配置事故进入项目页，并评估是否更新 Skill
- 只在用户明确要求或项目规则要求时写 agentMemory
- 任务回复列出修改文件、验证命令、结果和未完成风险
