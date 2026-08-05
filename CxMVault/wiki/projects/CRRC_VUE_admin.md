---
type: project
status: active
created: 2026-07-21
updated: 2026-07-29
project_id: CRRC_VUE_admin
project_lifecycle: active
knowledge_tier: full
config_source: repository
config_authority: project-files
agentmemory_status: verified
codegraph_status: verified
verification_status: verified
last_verified: 2026-07-29
source_refs:
  - E:\CodeXData\CRRC_VUE_admin\AGENTS.md
  - E:\CodeXData\CRRC_VUE_admin\crrcg-admin\package.json
  - E:\CodeXData\CRRC_VUE_admin\crrcg-admin\vite.config.js
  - E:\CodeXData\CRRC_VUE_admin\crrcg-admin\src\views\dataSetting\DataBase.vue
  - E:\CodeXData\CRRC_VUE_admin\crrcg-admin\src\views\dataSetting\components\DataTable.vue
  - E:\CodeXData\CRRC_API\AGENTS.md
  - E:\CodeXData\CRRC_API\plans\2026-07-22-crrc-dynamic-dataset-backend-implementation.md
  - E:\AIWorkspace\CxMVault\reviews\daily\2026-07-29.md
confidence: EXTRACTED
tags:
  - project
  - crrc
  - vue
  - vite
  - admin
---

# CRRC_VUE_admin

## 结论

`CRRC_VUE_admin` 是中车后台管理前端，实际应用位于 `crrcg-admin/`，使用 Vue 3、Vite、Element Plus、Vuex 和 Axios。对应后端为 [[CRRC_API]]，门户端为 [[CRRC_VUE_Index]]。

## 架构与联调

- 路由位于 `src/router/index.js`，页面位于 `src/views/`，API 位于 `src/api/`，统一请求实例位于 `src/utils/request.js`
- 登录链路为验证码 -> `/login` -> Cookie `crrc-token` -> Vuex 菜单 -> `/home`
- 本地后台管理实际监听 `127.0.0.1:5174`，`/api` 代理到 Admin `127.0.0.1:35698/crrc`
- CodeGraph 已初始化：75 文件、1,263 节点、3,001 条关系

## 动态字段改造现状

- 系统数据库管理当前直接批量新增、修改和删除物理字段，尚无旧字段/自定义字段/系统字段分类、锁定和依赖检查
- 七类数据的列表、表单和详情分散在独立页面，导入模板部分仍是 `/template/*.xlsx` 静态文件
- 改造应抽取共享 Schema 列表、搜索、表单和导入结果组件，同时保留钢材聚合、缺陷图片、字典和多 Sheet 等专用扩展
- 字段类型创建后不可修改；旧字段和系统字段不可删除，自定义字段删除必须由后端完成依赖检查和归档
- 本期复用现有角色、日志和数据菜单，不新增“数据分析管理”或完整“模型管理”菜单

## 后端可用契约（2026-07-22）

- 数据集、字段、使用范围、新表和字段归档删除统一位于`/database/datasets`
- 旧表新增CUSTOM字段继续调用`/database/batchOperateColumns`，请求必须携带幂等`operationNo`
- 算法字段映射路径为`/database/datasets/{sceneCode}/algorithms/{algorithmCode}/field-mappings`
- 算法映射应并入字段用途配置：只能从启用、数值、`algorithmCandidate=true`字段中分别选择`spacing`和`fraction`
- 后台页面仍需由贺成扬接入以上接口；后端完成不等于后台页面已经可操作

## 工具与复用入口

- 本地治理规则：`E:\CodeXData\CRRC_VUE_admin\AGENTS.md`
- 2026-07-29 已完成路径规范化，并通过 JSON-RPC initialize 验证 `agentmemory_crrc_vue_admin` 可用
