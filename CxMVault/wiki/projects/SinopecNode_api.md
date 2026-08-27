---
type: project
status: active
created: 2026-07-23
updated: 2026-08-19
project_id: SinopecNode_api
project_lifecycle: active
knowledge_tier: full
config_source: repository
config_authority: project-files
agentmemory_status: verified
codegraph_status: unknown
verification_status: verified
last_verified: 2026-08-19
source_refs:
  - E:\CodeXData\SinopecNode_api\AGENTS.md
  - E:\CodeXData\SinopecNode_api\pom.xml
  - E:\CodeXData\SinopecNode_api\sinopecnode-monolith\src\main\resources\application-dev.yml
  - E:\CodeXData\SinopecNode_api\sinopecnode-monolith\src\main\resources\application-test.yml
  - E:\CodeXData\SinopecNode_api\docs\api\monolith-migration-runbook.md
  - E:\CodeXData\SinopecNode_api\script\sql\sinopecnode-monolith-init.sql
  - E:\CodeXData\portal-login-test
  - E:\CodeXData\agentMemory\SinopecNode_api
confidence: EXTRACTED
tags:
  - project
  - SinopecNode_api
  - Java
  - modular-monolith
---

# SinopecNode_api

## 2026-08-14 模块化单体迁移（当前运行准则）

- 唯一可部署应用为 `sinopecnode-monolith`；auth、system、portal 与 resource/workflow 支持实现均只作为内部 JAR，不再有独立启动或 Docker 发布入口
- 单体使用 Spring MVC、Sa-Token 和 MyBatis，核心运行路径不再依赖 Nacos、Dubbo、服务发现、Spring Cloud Gateway、Sentinel 或 Seata
- 演练端口为 `32100`，只有完成数据、文件、健康检查、API 契约和 DemoTest 回归后才在维护窗口接管 `1047`
- 对外路径保持 `/auth/**`、`/system/**`、`/monitor/**`、`/portal/**`；门户 `/portal/**/file/**` 地址不变
- 开发与测试目标库分别为 `sinopecnode-monolith-dev`、`sinopecnode-monolith-test`。首次初始化与演练使用 `script/sql/sinopecnode-monolith-init.sql`：开发库只读，目标库必须为空，脚本复制所有表结构并仅保留基础配置、账号权限、门户内容和流程定义数据；运行态、日志与访问记录表保持为空。文件清单与哈希复制使用 `script/deploy/Copy-MonolithAssets.ps1`
- 切换必须使用新的单体 Sa-Token/SSO 密钥与 Redis DB 13、`sinopecnode:` 前缀，使旧会话自然失效并要求用户在 DemoTest 重新登录；禁止 Redis 全库清理
- 旧库、旧文件、旧服务镜像和远端 Nacos 内容在回滚窗口内只读保留。若健康、契约或数据校验失败，恢复旧服务至 `1047`；不得删除或覆盖旧资产
- 本地 `application.yml` 选择默认 dev Profile，`application-dev.yml` 与 `application-test.yml` 是唯一运行配置来源。当前用户明确授权开发/测试值保持本地明文；不得改成环境变量占位符，也不得在日志、项目页或交付说明中复制其内容

## 2026-08-19 单体架构收敛（当前运行准则）

- 根 Maven 聚合坐标为 `sinopecnode-monolith-parent`，唯一发布 JAR 为 `sinopecnode-monolith/target/sinopecnode-monolith.jar`
- 已从工作树移除 gateway、visual、gen、job、Nacos 模板、Docker 编排、分布式事务/限流/服务发现/Dubbo/消息总线支持模块、旧跨库 SQL 与其遗留构建产物；代码仅在 Git 历史保留
- resource/workflow 未删除，因为 auth、system、portal 仍通过内部 API 契约直接调用消息、文件和工作流实现；这些模块与 auth/system/portal 一同作为内部 JAR
- 原 `*.dubbo` 实现包已改为 `service.internal`，启动类扫描完整内部模块包；运行期不再保留 Dubbo 配置或资源
- `application.yml`、`application-dev.yml`、`application-test.yml` 不使用环境变量占位符或 Maven 资源过滤。dev 默认端口为 `32100`，test 为 `32101`；切换到 `1047` 通过备份并修改当前启用 Profile 的 `server.port` 完成
- 2026-08-19 已执行 `-pl sinopecnode-monolith -am -DskipTests=false test`：Reactor 测试全部通过，门户既有单元测试 11 项与单体测试 15 项均为 0 失败；随后 `-DskipTests package` 成功生成唯一可部署 JAR，归档静态检查确认不含已移除云组件且三个 Profile 文件均不含占位符。新 clean JAR 已用 dev Profile 在 `32100` 成功启动，`/auth/code` 返回业务码 200；`/portal/home/config` 按源码 `@SaCheckLogin` 返回未登录业务码 401，符合既有权限语义。test Profile 已确认选择 `sinopecnode-monolith-test`，但该库尚未执行迁移，缺少表时会在启动期失败；未经单独授权不得向测试库写入迁移数据

## 2026-08-19 单体目录与初始化基线

- 顶层 `api/` 已移除；原 system/resource/workflow 跨模块 DTO 与服务接口统一归入 `common/common-contract` 的 `*.contract` 包，并按 `System*`、`Resource*`、`Workflow*` 命名，消除旧 Dubbo `Remote*` 语义且避免 system 与 resource/workflow 形成循环依赖
- 原 `auth/` 已归入 `modules/auth/`，与 system、portal、resource、workflow 同为内部 JAR；它不是独立部署服务
- 仓库 SQL 收敛为 `script/sql/sinopecnode-monolith-init.sql`。默认从 `sinopecnode-monolith-dev` 初始化空的 `sinopecnode-monolith-test`，不存储开发数据、密码或连接信息；运行时通过跨库 `CREATE TABLE ... LIKE` 与 `INSERT ... SELECT` 完成结构与选定数据复制
- 初始化脚本不覆盖非空目标库。保留数据包括平台基础配置、账号权限、门户内容、外部资源和流程定义；不复制登录/操作/电话日志、外部资源访问记录、流程实例及任务、代码生成记录、测试请假和事务回滚记录
- 2026-08-19 已执行 `-pl sinopecnode-monolith -am clean package`：33 个 Reactor 模块构建成功，测试 26 项全部通过。检查最终单体嵌套模块 JAR 后，未发现旧 `*.api` 包或 `Remote*` 字节码，且包含 `common-contract` 与 `modules/auth` 内部 JAR

下方内容仅为旧微服务/Nacos 环境审计，不是单体启动或配置指令。

迁移、切换与回滚完整步骤以 `E:\CodeXData\SinopecNode_api\docs\api\monolith-migration-runbook.md` 为准。

## 项目定位（历史微服务审计）

`SinopecNode_api` 是中石化骨干节点微服务后端，工程路径为 `E:\CodeXData\SinopecNode_api`。项目以 `SteelTechnologyNode_api` 当前工作树作为初始化基线，根 Maven 坐标调整为 `org.dromara:sinopecnode-cloud-plus:2.4.1`。

## 服务边界（历史微服务审计）

- `sinopecnode-gateway`：当前本地联调端口 1047
- `sinopecnode-auth`：认证中心，默认端口 32001
- `sinopecnode-system`：系统管理，当前本地联调端口 32102（2026-08-10 已核验）
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
- 发布前必须读取远端元数据中的配置 `type`；写入请求显式携带该类型，写后立即回读元数据确认类型和脱敏内容摘要均未偏离。不能依据 `.yml` 后缀推断 Nacos 会保留 YAML 类型
- 本机 Nacos 状态物理位于 `D:\CodeX\AppData\nacos`；`C:\Users\CxM\nacos` 是兼容 Junction，客户端恢复目录经该入口仍可见于 `config\Config-fixed-sinopecnode-dev-localhost_30050_nacos\`。不得作为常规清理对象或冒充远端当前事实；迁移时必须停 Java 并整体核验 `conf/config/data/logs/naming`，不得只删 snapshot
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
- 文件匿名读取分别为 `/portal/home/banner/file/**` 与 `/portal/news/cover/file/**`；保存时替换或删除后的旧文件仅在事务提交后回收。上传后取消编辑或保存失败产生的孤儿图片由门户定时任务统一回收，前端不调用图片释放接口
- 首页配置编辑页必须显式保存才立即生效；未保存退出继续展示上一已发布版本。行业动态可配置展示条数、按发布时间倒序，或从已发布资讯中人工勾选并按置顶权重排序

### 每次本地启动前的固定检查

1. 代码、SQL 与 Nacos 配置必须同一版本；不要只同步 Nacos 或只执行 system 库脚本
2. 新环境执行 `script/sql/sinopecnode-portal-feature-init.sql`；当前已部署环境已完成门户历史迁移。未来存量环境的数据迁移必须单独评审并交付可回滚脚本
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
- 先无凭据验证 `/auth/code` 及首页 Banner 文件读取；`/portal/home/config` 明确要求登录，须在复用已验证的本地会话后验证，再回归后台受保护接口。Codex 内置浏览器若因 URL policy 无法访问 `127.0.0.1`，先用端口监听或公共接口确认本机服务状态，再改用已连接 Chrome 的同 origin DemoTest；这是客户端策略限制，不得为绕过它修改网关端口、门户路由或登录流程

### 最小验收闭环

1. 无凭据读取 Banner 文件和 `/auth/code`，确认公共链路与验证码服务可用
2. 先由本地登录页的“读取用户信息”验证并复用现有会话；只有会话无效/冻结时才由用户以后台 appCode 重新登录。随后验证要求登录的 `/portal/home/config` 及 `/portal/admin/news/**` 的列表、详情、草稿、发布、下架与删除；编辑页新增发布和草稿编辑发布都只调用一次 `POST /portal/admin/news/publish`，已发布资讯必须先下架
3. 上传临时封面后取消保存，确认前端不调用释放接口；通过降低临时图片保留期并等待任务执行，确认无引用文件被回收。删除资讯后，以随机查询参数和 `cache: no-store` 读取封面。全局异常可能返回 HTTP 200 加业务码，必须按业务码而非仅 HTTP 状态判断“文件不存在”
4. 验证 `/portal/admin/home-config/**` 保存后立即生效：替换单张 Banner、主副标题、资讯展示数量和手动置顶关联；未保存退出不得影响 `/portal/home/config`
5. 清理测试资讯、关联和临时文件，确认不留下业务记录或磁盘文件

### 本次根因与防回归结论

- 首次草稿创建失败的根因是运行库未创建 `portal_news`，不是权限、网关或请求字段问题
- 浏览器对 UUID 封面地址启用了长期缓存；删除后的缓存命中不能证明文件仍存在，回归测试必须禁用缓存并解析统一异常业务码
- 本地登录页曾保留其他项目的网关与 appCode 默认值，启动前必须核对为当前项目值；默认值已改为中石化节点后台配置
- 最大的流程缺口不是业务代码，而是路由重构后没有同步 Runbook，且此前本项目未注册专用 agentmemory MCP。现已注册该 MCP 并写入首条回归 Runbook；此后通过根 `AGENTS.md` 的强制前置步骤和本页回退入口防止再次依赖过期上下文
- 2026-07-29 再次重复登录的直接原因是旧规则写成“获取新会话”，与 DemoTest 已持久化并可探测现有会话的实现冲突；现已改为同 origin、同 Chrome profile 下 session-first，并把入口、会话策略和专用回归 Skill 纳入机器可读路由
- 上传、草稿、发布、下架、删除、封面回收、Banner 本地存储和首页配置保存均应以自动化单元测试覆盖；当前门户定向测试为 31 项通过，其中包含新增并发布、草稿编辑并发布及富文本正文保留分支

## 2026-08-06 数据产品模块交付与配置发布复盘

### 已确认的功能边界

- 数据产品按租户隔离；后台新增、编辑、删除与前台列表、详情读取均使用当前租户上下文
- 后台保存后前台直接读取同一持久化数据，不保留发布或缓存中间态；卡片不再展示使用次数
- 卡片能力区块、产品亮点、富文本详情与应用场景均由后台配置；分类复用系统字典，不新增数据产品分类查询接口。网关对接路径为 `GET /system/dict/data/type/portal_data_product_category`
- Banner、资讯封面和数据产品图片的独立上传接口均采用后端回收：保存提交后立即清理不再引用的旧图，取消编辑或保存失败的孤儿文件由 `SysPortalImageCleanupTask` 定时回收。任务跨租户查询三类业务记录，并按文件名比对引用，因此三类图片即使使用同一物理目录也不会因不同 URL 前缀误删
- 定向 Maven 测试已通过 5 项；同源 DemoTest 端到端闭环已覆盖系统字典读取、上传、后台新增、前台卡片/详情即时可见、后台修改即时可见和删除后前台不可见，测试数据已清理

### Nacos 配置类型事故与固定防线

- 事故根因：此前通过 Nacos HTTP 接口发布公共配置时，只提交了内容而未显式携带、发布后也未核验配置 `type`，使原 YAML 条目被 Nacos 标记为 `TEXT`
- 恢复事实：用户已恢复配置类型；2026-08-06 只读核验 `127.0.0.1:30050 / sinopecnode-dev / DEFAULT_GROUP / sinopecnode-application-common.yml` 的远端元数据为 `yaml`
- 此后任何 Nacos 写入必须遵循：读取远端元数据类型 → 备份并比对脱敏摘要 → 用户确认精确目标 → 请求显式携带原类型 → 写后回读元数据与摘要。任一步不符即停止写入并从历史/备份恢复，禁止再以内容发布“试修”
- 本次数据产品富文本例外仅涉及公共配置中后台保存路径；该变更需要在类型保护流程内发布，不可因本地 YAML 模板正确就跳过远端类型核验

### 新对话执行顺序

1. 先读取本项目页、项目 `AGENTS.md` 和 `sinopec-portal-regression` Skill，再读取远端 Nacos 当前元数据；不得根据旧聊天、模板或快照发布配置
2. 先进行公共接口和端口检查；受保护回归只复用 `http://127.0.0.1:5177` 同 origin 的 DemoTest 会话，以“读取用户信息”判定会话，不重复索要登录或尝试导出 Token
3. 网关路径按当前路由验证；系统字典从 `/system/dict/**` 进入，门户接口从 `/portal/**` 进入，禁止根据服务名或旧路由猜测

## 后续任务入口

- 先读项目根 `README.md`
- 项目治理规则见根 `AGENTS.md`
- system 和 portal 的边界分别见 `modules/system/AGENTS.md`、`modules/portal/AGENTS.md`
- 门户本地 Profile 配置与接口说明见 `docs/api/`
- 门户登录、资讯和首页配置回归使用 `D:\CodeX\.codex\skills\sinopec-portal-regression\SKILL.md`

## 2026-08-12 门户完整初始化脚本与 Nacos 模板同步复盘

### 已整理交付

- `script/sql/sinopecnode-portal-feature-init.sql` 是新环境唯一的门户功能初始化入口，按 `sinopecnode-databases.sql`、`sinopecnode-cloud.sql`、该脚本的顺序执行
- 脚本覆盖 10 张当前门户实体表：资讯、首页配置与置顶关联、数据产品及其亮点/能力/条目/场景、外部资源及访问记录；同时幂等初始化资讯/数据产品/外部资源分类、外部资源 URL 检测白名单参数、资讯/首页/数据产品/外部资源后台菜单及按钮权限
- 不写入资讯、数据产品或外部资源演示数据；用户已确认当前部署环境完成数据产品、外部资源与资讯公开字段迁移，三份对应增量脚本已从工作树删除并保留 Git 历史。未来有存量数据的升级迁移仍须单独评审，不以完整初始化脚本替代
- 2026-08-12 从 `sinopecnode-cloud.sys_menu` 只读核验当前门户运行菜单树：`登录权限(2057732380823740418)` → `菜单管理(2081579208106786817)` → `首页配置(2081581007702278146)`、`数据产品(2081581280013271042)`、`资讯管理(2081581470262706178)`、`外部资源库(2081581657660014594)`；初始化脚本已按此树补齐父级、路由、组件与排序。数据产品/外部资源的后端权限菜单仍保持当前库中的系统菜单父级 `1`，首页与资讯按钮权限改挂到最新组件节点；本次只读核验未发现这五个运行菜单的角色菜单映射

### Nacos 只读核验与模板结论

- 读取定位：`dev / localhost:30050 / sinopecnode-dev / DEFAULT_GROUP`；远端读取全程只读，未发布、导入或覆盖任何 dataId
- 2026-08-12 10:05:20 +08:00 对 `sinopecnode-datasource.yml` 进行了紧邻模板更新的认证直读核验，远端摘要 SHA-256 为 `2ea2fbbc5e7e937b16a6c4db1d614bac988eadeec3a0babac340bc117f5ff57f`
- 核验的数据库目标为：`system-master` 和 `gen` 指向 `sinopecnode-cloud`，`portal-master` 指向 `sinopecnode-portal`，`job` 指向 `sinopecnode-job`，`workflow` 指向 `sinopecnode-workflow`；本地 datasource 模板与上述五项一致
- 已将远端已验证的门户图片匿名读取规则同步到 gateway 模板，包括 Banner、资讯封面、数据产品图片和外部资源图标；门户模板补齐数据产品图片本地存储路径与访问前缀
- 本地存在但本次远端未读到的 `sentinel-dashboard.yml`、`sinopecnode-gen.yml`、`sinopecnode-job.yml`、`sinopecnode-monitor.yml`、`sinopecnode-workflow.yml` 与 `snailjob-server.yml` 仅标记为未远端核验，保留作模板，不自动删除或发布

### 固定防线

- 远端配置可在连续读取期间更新。涉及数据归属、路由、认证、存储位置的关键项，在写回模板前必须再次进行紧邻写入的窄范围认证只读核验，并以最后一次成功读取为准
- 模板只同步非敏感结构、键和环境变量占位符；不得将远端密码、Token、私钥、第三方凭据或完整敏感配置正文写入仓库、项目页或 agentMemory

## 2026-08-17 单体 Sa-Token DAO 主 Bean 冲突修复

- 启动日志出现 `NoUniqueBeanDefinitionException`：`SaAloneRedisInject` 注入 `SaTokenDao` 时同时发现框架 Redis DAO、通用 DAO 和租户 DAO 三个主候选；这是 Bean 装配冲突，不是本地 `application.yml` 的值、Redis 连通性或数据库问题
- 单体保留 `TenantSaTokenDao` 作为唯一主 DAO，通用 `SaTokenConfiguration#saTokenDao` 不再标记为主候选
- `sinopecnode-monolith/pom.xml` 对 `common-satoken` 排除 `sa-token-redis-template` 与 `sa-token-alone-redis`，避免单体载入默认 Redis DAO 和独立 Redis 注入器；租户隔离仍使用现有统一 Redis 配置
- 验证：2026-08-17 定向 Maven 测试 1 项通过；依赖树不含上述两个运行依赖；重新打包后单体成功监听 `32100`，新启动日志未再出现该主候选冲突

### 构建产物与根因补充

- 版本差异确认基础 `SaTokenConfiguration#saTokenDao` 的 `@Primary` 是单体迁移提交新增；恢复原行为应仅保留 `TenantConfiguration#tenantSaTokenDao` 为主候选，`sa-token-redis-template` 不是必须移除的根因
- 移除 `@Primary` 后若仍见旧异常，先核验 Maven 产物是否更新：一次 `clean install` 因正在运行的任务测试实例占用 `sinopecnode-monolith/target/sinopecnode-monolith.jar` 而在 clean 阶段失败，旧 JAR 与本地仓库依赖仍含旧字节码
- 2026-08-17 停止该任务测试实例后，以 `-pl sinopecnode-monolith -am` 重编译公共依赖，再单独重建单体；新 JAR 在 `32100` 成功启动，未再出现 `NoUniqueBeanDefinitionException`。单体配置文件未改动
