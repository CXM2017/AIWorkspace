---
type: overview
status: active
created: 2026-07-02
updated: 2026-07-29
source_refs:
  - 00-开始使用.md
  - schema/projects.yaml
  - schema/AGENTS.md
  - raw/legacy/codexknowledge/index.md
  - raw/legacy/agentmemory-index/index.md
confidence: EXTRACTED
tags:
  - overview
  - cxmvault
  - llm-wiki
---

# CxMVault 总览

## 定位

`CxMVault` 是统一个人知识库，不绑定单一 agent。它服务两类使用者：

- 人：用 Obsidian 浏览、复盘、发现关联
- Agent：用稳定目录、索引、frontmatter 和维护契约读取、编译、验证知识

## 使用闭环

```mermaid
flowchart LR
  A["Capture: raw/inbox"] --> B["Daily Ingest: reviews/daily"]
  B --> C["Compile: wiki"]
  C --> D["Weekly Review: reviews/weekly"]
  D --> E["Lint: tools/Test-CxMVault.ps1"]
  E --> C
```

日常使用从 [[../00-开始使用|00-开始使用]] 进入。新文章、新知识、网页内容、截图和临时想法先进入 `raw/inbox/`，每天消化，每周复盘，每月整理结构。

## Karpathy 分层

- `raw/`：原始资料和 legacy source，不直接当作最终结论
- `wiki/`：LLM 编译后的结构化知识
- `schema/`：跨 agent 维护契约
- `schema/projects.yaml`：项目身份、路径、能力与配置权威的唯一登记册
- `views/`：Project Registry 与 Inbox Review 的 Obsidian Bases 视图
- `reviews/`：每日消化、每周复盘、每月整理
- `logs/`：系统维护日志
- `outputs/`：报告、图谱和导出物
- `tools/`：健康检查和迁移辅助脚本

## 旧库关系

- `E:\CodeXData\CodeXKnowledge`：旧 Obsidian 项目知识库，作为 legacy source
- `E:\CodeXData\agentMemory`：旧项目机器记忆，作为 bridge source
- 旧库不被删除、不被搬空、不被静默覆盖

## 当前优先级

1. 新项目和新对话先通过 Registry、项目 AGENTS、项目页与 agentMemory 装载必要上下文
2. 当前代码以仓库为准；Nacos 运行配置以目标远端当前内容为准，仓库模板与 snapshot 只作定位、对照和恢复
3. 保持旧项目经验可检索，但 legacy source 不覆盖已验证的新事实
4. 把重复流程提升为 Skill 或 operation，减少全局规则膨胀和同类问题反复询问
5. 用健康检查、Base 视图和来源追溯发现状态漂移
