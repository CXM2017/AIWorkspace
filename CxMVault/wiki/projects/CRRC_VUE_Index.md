---
type: project
status: active
created: 2026-07-21
updated: 2026-07-22
source_refs:
  - E:\CodeXData\CRRC_VUE_Index\AGENTS.md
  - E:\CodeXData\CRRC_VUE_Index\ccrcg-index\package.json
  - E:\CodeXData\CRRC_VUE_Index\ccrcg-index\vite.config.js
  - E:\CodeXData\CRRC_VUE_Index\ccrcg-index\src\util\aixos.js
  - E:\CodeXData\CRRC_API\AGENTS.md
  - E:\CodeXData\CRRC_API\CrrcgcMaterialGene\CrrcgcMaterialGene-base\src\main\java\com\atsteel\controller\LoginController.java
  - E:\CodeXData\CRRC_API\plans\2026-07-22-crrc-dynamic-dataset-backend-implementation.md
confidence: EXTRACTED
tags:
  - project
  - crrc
  - vue
  - vite
  - pinia
  - frontend
---

# CRRC_VUE_Index

## 结论

`CRRC_VUE_Index` 是中车材料基因工程的 Vue 前端仓库，实际应用位于 `ccrcg-index/`。项目使用 Vue 3、Vite、Element Plus、Pinia 和 Axios，对应后端为 [[CRRC_API]]。

## 架构与代码锚点

- 应用入口：`ccrcg-index/src/main.js`，统一注册 Pinia 持久化、路由、Element Plus 和全局拖拽指令
- 路由：`ccrcg-index/src/router/router.js`，覆盖材料数据库、数据分析、材料/结构性能预测、关系图谱和个人中心
- HTTP：`ccrcg-index/src/util/aixos.js`；API 封装在 `src/api/`，通用分页在 `src/hookes/tableData.js`
- 状态：`src/store/` 管理用户、数据集、材料对比和静态选项；页面应复用现有状态与组合逻辑

## 动态字段改造现状

- 材料数据首页目前硬编码七类导航、数字类型和组件映射；数据分析页另有七类 API、固定化学成分和性能字段映射
- 详情、加入对比、图表和导出均有各自固定映射，且材料详情当前只覆盖类型 `0、1、4、5、6`，类型 `2、3` 需纳入改造回归
- 高通量预测页的表单和导入导出字段由固定对象控制，新增字段只有经算法配置明确支持后才能进入计算
- 新简单表要自动出现，必须把菜单、Schema、通用列表/详情/分析/预测输入串成一条链路，不能只增加菜单接口

## 后端可用契约（2026-07-22）

- 模块菜单与字段Schema已由`/datasets/menu`、`/datasets/{sceneCode}/schema`提供
- 分页、详情、增删改、导入模板、导入校验提交和导出均已由`/datasets/{sceneCode}`统一提供
- 动态分析入口为`/analysis/query`，字段、过滤方式和聚合均按Schema白名单校验
- 算法输入Schema为`/algorithms/schema`，动态预测为`/algorithms/predict`；映射未配置完整时应禁用计算并显示后端错误
- 门户页面仍需由贺成扬完成动态组件接入和七类场景回归；旧数字路由0至6继续保留

## 前后端联调约定

- 前端 Axios 基址为 `/api`，Vite 代理将其转发至后端 `/crrc` 并移除 `/api` 前缀
- 请求由统一拦截器从 `sessionStorage` 注入 Bearer token；响应 `code === 0` 表示成功，`-100` 或 `401` 进入统一登出流程
- 登录链路为前端 `POST /api/login` 与 `GET /api/captcha` 对接后端 `LoginController`；后端将验证码写 Redis，登录后返回 Shiro Session ID token 和用户会话
- 个人中心请求会补充当前用户 ID；新增接口不能绕过用户归属、Shiro 鉴权或后端 `RetData` 响应契约

## 治理与验证

- 根目录 `AGENTS.md` 已按实际结构建立前端规则，`.codegraph/` 已加入根 `.gitignore`
- 前端 CodeGraph：89 文件、1,881 节点、4,530 条关系；后端 CodeGraph 已就绪，可用于跨端调用链定位
- 现有 `package-lock.json` 是当前依赖锁定基线；日常命令使用 pnpm 且不生成新的 pnpm lock，未明确要求时不迁移或重写锁文件
- 当前无 test/lint script；涉及业务改动时从 `ccrcg-index/` 执行 pnpm 的 Vite 构建作为最小构建验证

## 本地启动验证（2026-07-21）

- 开发代理已由旧内网地址切换至本机 Admin 服务 `127.0.0.1:35698/crrc`，保留 `/api` 重写与 `/crrc` 上下文
- 用户明确说明后端已启动时，先验证本机端口并将代理切至本机，再启动 Vite；不得先按遗留远端配置启动
- 原锁文件引用已失效的 Element Plus 预发布 URL；已改为同版本 `2.10.1` 的 npm 官方发布包，并补齐 Vite 配置所需的 `terser 5.49.0`
- `npm ci` 与 `npm run build` 均通过；真实浏览器经本机 Vite 访问材料数据库页并加载用户、数据集和材料列表，`/api/captcha` 返回 `200 image/jpeg`
- 2026-07-21 当前进程验证：门户实际监听 `127.0.0.1:5173`，通过 CLI `--host 127.0.0.1` 覆盖 Vite 文件中的固定 host，代理指向 Admin `35698/crrc`
- agentMemory 目录和 MCP 配置已补为 `E:\CodeXData\agentMemory\CRRC_VUE_Index` / `agentmemory_crrc_vue_index`；需重启 Codex 后初始化并验证工具出现
