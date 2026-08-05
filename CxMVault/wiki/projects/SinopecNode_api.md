---
type: project
status: active
created: 2026-07-23
updated: 2026-07-29
project_id: SinopecNode_api
project_lifecycle: active
knowledge_tier: full
config_source: nacos
config_authority: remote-current
agentmemory_status: verified
codegraph_status: unknown
verification_status: verified
last_verified: 2026-07-29
source_refs:
  - E:\CodeXData\SinopecNode_api\AGENTS.md
  - E:\CodeXData\SinopecNode_api\pom.xml
  - E:\CodeXData\SinopecNode_api\gateway\src\main\resources\application.yml
  - E:\CodeXData\SinopecNode_api\modules\portal\src\main\resources\application.yml
  - E:\CodeXData\SinopecNode_api\script\config\nacos\DEFAULT_GROUP
  - E:\CodeXData\portal-login-test
  - E:\CodeXData\agentMemory\SinopecNode_api
confidence: EXTRACTED
tags:
  - project
  - SinopecNode_api
  - Java
  - microservice
---

# SinopecNode_api

## 项目定位

`SinopecNode_api` 是中石化骨干节点微服务后端，工程路径为 `E:\CodeXData\SinopecNode_api`。项目以 `SteelTechnologyNode_api` 当前工作树作为初始化基线，根 Maven 坐标调整为 `org.dromara:sinopecnode-cloud-plus:2.4.1`。

## 服务边界

- `sinopecnode-gateway`：当前本地联调端口 1047
- `sinopecnode-auth`：认证中心，默认端口 32001
- `sinopecnode-system`：系统管理，默认端口 32002
- `sinopecnode-portal`：前台门户独立服务，当前本地联调端口 32103
- `sinopecnode-resource`：资源服务，默认端口 32004
- `sinopecnode-gen`：代码生成，默认端口 32005
- `sinopecnode-job`：任务服务，默认端口 32006
- `sinopecnode-workflow`：工作流服务，默认端口 32007

门户业务已从 `modules/system` 搬迁到 `modules/portal`，独立注册、部署和访问 `sinopecnode-portal` 数据库。门户通过 `api-system` 的 Dubbo 契约访问用户与字典能力，不直接依赖 system 私有 Mapper 或 Service。

## 数据库与配置

数据库统一使用以下命名：

- `sinopecnode-cloud`
- `sinopecnode-portal`
- `sinopecnode-job`
- `sinopecnode-workflow`
- `sinopecnode-config`
- `sinopecnode-seata`

Nacos 模板位于 `script/config/nacos/DEFAULT_GROUP/`，核心 dataId 统一使用 `sinopecnode-*`。数据库、Redis、JWT、OSS、监控、任务调度和第三方集成凭据均通过环境变量或配置中心提供，仓库模板不保存明文敏感值。

### Nacos 运行事实

- 运行时配置以目标 Nacos 服务端 namespace/group/dataId 的当前内容为最新事实；仓库模板只用于定位、初始化和差异对照，本机 snapshot/cache 只用于恢复
- `dev` 与 `local` 都声明为默认 profile，启动与诊断必须显式使用 `-P<profile>` 并记录解析出的 server、namespace、group、dataId；当前 dev/local 定位为 `localhost:30050 / sinopecnode-dev / DEFAULT_GROUP`
- Gateway、Auth 读取 `sinopecnode-application-common.yml` 与服务 dataId；业务服务还读取 `sinopecnode-datasource.yml`。snapshot 中未出现某个 dataId 不能证明服务端不存在
- 默认只读核对远端当前内容；发布、初始化或覆盖必须由用户对精确目标单独授权，且先导出现有内容、记录来源并准备回滚
- 客户端恢复目录 `C:\Users\CxM\nacos\config\Config-fixed-sinopecnode-dev-localhost_30050_nacos\` 不属于常规清理范围，也不能冒充远端当前事实
- 项目规则详见 `E:\CodeXData\SinopecNode_api\AGENTS.md` 的“Nacos 运行事实与配置安全”

## 初始化脚本

MySQL 初始化顺序：

1. `script/sql/sinopecnode-databases.sql`
2. `script/sql/sinopecnode-cloud.sql`
3. `script/sql/sinopecnode-portal-feature-init.sql`
4. job、workflow、config、seata 对应脚本

门户初始化脚本同时创建门户表、资讯分类字典和按钮权限，不写入原参考项目的钢铁业务示例数据。

## 已验证基线

- portal 单元测试：31 项，0 失败、0 错误、0 跳过
- Maven Reactor：58 个模块全量打包成功
- system 中门户路由文件：0
- portal 仅保留首页配置、资讯管理与第三方嵌入授权；后台 Controller 以 `Sys` 前缀区分，前台门户 Controller 不使用 `Sys` 前缀
- 敏感配置字面量审计：0
- 旧项目标识残留审计：0

## 2026-07-29 门户配置与资讯管理：本地启动到功能验收 Runbook

### 已交付边界

- 门户服务只承载首页配置、资讯管理和第三方嵌入授权；历史科技门户的数据集、模型应用、材料区块链等代码已从当前中石化节点门户范围清理
- 网关以一个 `/portal/**` 路由转发门户服务，不再为后台、前台、文件读取拆分重复路由
- 后台资讯接口统一为 `/portal/admin/news/**`；首页配置后台接口统一为 `/portal/admin/home-config/**`；前台首页读取为 `/portal/home/config`
- 前台资讯详情统一为 `GET /portal/news/{id}`；登录后的页面实际展示时调用 `POST /portal/news/{id}/view` 累计一次 PV，两个接口只处理已发布且未删除资讯，不保存用户浏览记录
- 仅支持草稿、已发布、即时发布与下架；已发布资讯必须下架后才可编辑或删除
- 资讯编辑页的“发布资讯”统一调用 `POST /portal/admin/news/publish` 并提交完整表单：不传 `id` 时新增并发布，传入草稿 `id` 时编辑并发布；`PUT /portal/admin/news/{id}/publish` 仅用于列表页对未改内容的草稿执行快捷发布
- 首页 Banner 与资讯封面均使用门户服务本地/服务器持久化目录，不使用 OSS；地址必须为上传接口返回的受管相对 URL。首页 Banner 仅读取一张图、不轮播、跳转链接可为空
- 文件匿名读取分别为 `/portal/home/banner/file/**` 与 `/portal/news/cover/file/**`；临时上传、替换或删除后的物理文件仅在事务提交后回收
- 首页配置编辑页必须显式保存才立即生效；未保存退出继续展示上一已发布版本。行业动态可配置展示条数、按发布时间倒序，或从已发布资讯中人工勾选并按置顶权重排序

### 每次本地启动前的固定检查

1. 代码、SQL 与 Nacos 配置必须同一版本；不要只同步 Nacos 或只执行 system 库脚本
2. 新环境执行 `script/sql/sinopecnode-portal-feature-init.sql`；该脚本用于新功能初始化，已部署环境的数据迁移必须单独评审并交付可回滚脚本
3. 初始化脚本会在 `sinopecnode-portal` 建立资讯、首页配置及关联表，并在 `sinopecnode-cloud` 写入字典和按钮权限；若新增或保存失败，先核对当前门户数据源和 SQL 版本，不要先改 Controller 或请求体
4. 网关 Nacos 仅需包含 `/portal/**` 到 `sinopecnode-portal` 的显式转发，且服务发现自动路由必须关闭；门户 Nacos 将 `springdoc.api-docs.path` 设为 `/portal/v3/api-docs`。网关为该文档路径配置 `PreserveHostHeader`，只保留网关 Host、不重写路径也不传递人工前缀。门户首页配置、Banner、资讯封面、资讯详情和浏览量接口均必须登录，不加入匿名白名单。前端只使用 `/portal/**`，不使用 `/sinopecnode-portal/portal/**` 服务名别名
5. 公共 Nacos 的 `xss.excludeUrls` 必须包含 `/portal/admin/news` 与 `/portal/admin/news/publish`，否则全局过滤器会删除富文本正文的 HTML 标签和行内样式；该例外只用于后台正文写入，标题和摘要继续由字段级 `@Xss` 校验
6. 代码或 Nacos 变更后重启受影响的网关和门户服务；关闭服务发现自动路由后，已通过旧 `/{serviceId}/v3/api-docs` 访问过文档的服务也要重启，以清除 SpringDoc 缓存的旧服务名前缀。数据库、网关和门户中任一环节未更新，都不能把接口异常归因于业务实现
7. OpenAPI 的 `servers` 承载网关前缀，`paths` 保持服务内部原始路径；禁止再按 `X-Forwarded-Prefix` 修改 `paths`。门户 Controller 自身已带 `/portal`，其文档端点也必须保持 `/portal/v3/api-docs`，不能由网关重写或人为传递该前缀，否则 Apifox 会组合出重复路径

### 登录与联调安全边界

- 每次启动、重启、登录或回归前，先读取本项目页的本 Runbook；`agentmemory_sinopecnode_api` 已注册，存储根为 `E:\CodeXData\agentMemory\SinopecNode_api`。当前会话未刷新而工具尚未出现时，本页是唯一的持久化回退入口，不能跳过
- 登录授权的机器可读路由为 `auth_workflow=local-demo-first`，测试入口为 `E:\CodeXData\portal-login-test`（DemoTest）：在该目录执行 `& 'D:\Program Files\Python313\python.exe' -m http.server 5177 --bind 127.0.0.1`，访问 `http://127.0.0.1:5177`；网关填写 `http://127.0.0.1:1047`
- 后台管理使用 appCode `sinopecnode-admin`，门户前台使用 `sinopecnode-portal`；Client ID 和登录凭据仅从仓库外私有测试访问文件读取
- 验证码从当前 Redis 读取；Token、验证码、密码、Authorization 和完整登录响应不得写入仓库、日志、wiki 或测试报告
- 本地登录 Demo 仅在当前 origin 保存登录会话并显示脱敏结果，不展示 `access_token`；禁止输出验证码 UUID、完整登录响应或用户详情，更不得复制 Token 到仓库、知识库、普通日志或截图说明；静态页脚本修改后为 `app.js` 增加版本查询参数并刷新，避免浏览器继续执行缓存的旧脚本
- 固定顺序为：公共接口无凭据检查 → 打开/复用 DemoTest → 点击“读取用户信息”验证现有本地会话 → 会话无效或被冻结时才由用户在 DemoTest 输入验证码重新登录 → 受保护接口回归 → 清理测试数据
- 代码证据：`portal-login-test/app.js` 仅在同 origin 保存 access token/clientId，且不将 Token 写入页面结果；“读取用户信息”和“材料库流程检查”均在页面内部复用会话，清空结果或加载页面都不会退出登录
- 会话复用必须保持用户现有 Chrome profile 与精确 origin `http://127.0.0.1:5177`；`localhost`、`file://`、其他端口、新 profile 或独立浏览器实例都不能视为原会话
- Chrome 只作为本地 DemoTest 的浏览器驱动；DemoTest 可用时禁止改走其他登录页、重写登录链路、从 `localStorage` 导出 Token 或让用户在另一个页面重复登录
- 本地 DemoTest 缺失或当前证据证明不可用时，先记录路径/端口/接口失败证据，再提出最小兜底；不能仅因通用浏览器流程更熟悉就跳过已登记入口
- 先无凭据验证 `/auth/code`、`/portal/home/config` 及首页 Banner 文件读取；随后复用已验证的本地会话，再验证后台受保护接口。Codex 内置浏览器若因 URL policy 无法访问 `127.0.0.1`，先用端口监听或公共接口确认本机服务状态，再改用已连接 Chrome 的同 origin DemoTest；这是客户端策略限制，不得为绕过它修改网关端口、门户路由或登录流程

### 最小验收闭环

1. 无凭据读取 `/portal/home/config`、Banner 文件和 `/auth/code`，确认公共链路与验证码服务可用
2. 先由本地登录页的“读取用户信息”验证并复用现有会话；只有会话无效/冻结时才由用户以后台 appCode 重新登录。随后验证 `/portal/admin/news/**` 的列表、详情、草稿、发布、下架与删除；编辑页新增发布和草稿编辑发布都只调用一次 `POST /portal/admin/news/publish`，已发布资讯必须先下架
3. 上传临时封面后释放，确认封面不可读取；删除资讯后，以随机查询参数和 `cache: no-store` 读取封面。全局异常可能返回 HTTP 200 加业务码，必须按业务码而非仅 HTTP 状态判断“文件不存在”
4. 验证 `/portal/admin/home-config/**` 保存后立即生效：替换单张 Banner、主副标题、资讯展示数量和手动置顶关联；未保存退出不得影响 `/portal/home/config`
5. 清理测试资讯、关联和临时文件，确认不留下业务记录或磁盘文件

### 本次根因与防回归结论

- 首次草稿创建失败的根因是运行库未创建 `portal_news`，不是权限、网关或请求字段问题
- 浏览器对 UUID 封面地址启用了长期缓存；删除后的缓存命中不能证明文件仍存在，回归测试必须禁用缓存并解析统一异常业务码
- 本地登录页曾保留其他项目的网关与 appCode 默认值，启动前必须核对为当前项目值；默认值已改为中石化节点后台配置
- 最大的流程缺口不是业务代码，而是路由重构后没有同步 Runbook，且此前本项目未注册专用 agentmemory MCP。现已注册该 MCP 并写入首条回归 Runbook；此后通过根 `AGENTS.md` 的强制前置步骤和本页回退入口防止再次依赖过期上下文
- 2026-07-29 再次重复登录的直接原因是旧规则写成“获取新会话”，与 DemoTest 已持久化并可探测现有会话的实现冲突；现已改为同 origin、同 Chrome profile 下 session-first，并把入口、会话策略和专用回归 Skill 纳入机器可读路由
- 上传、草稿、发布、下架、删除、封面回收、Banner 本地存储和首页配置保存均应以自动化单元测试覆盖；当前门户定向测试为 31 项通过，其中包含新增并发布、草稿编辑并发布及富文本正文保留分支

## 后续任务入口

- 先读项目根 `README.md`
- 项目治理规则见根 `AGENTS.md`
- system 和 portal 的边界分别见 `modules/system/AGENTS.md`、`modules/portal/AGENTS.md`
- 门户环境变量与接口说明见 `docs/api/`
- 门户登录、资讯和首页配置回归使用 `D:\CodeX\.codex\skills\sinopec-portal-regression\SKILL.md`
