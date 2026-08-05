---
type: project
status: active
created: 2026-07-02
updated: 2026-07-29
project_id: SteelTechnologyNode_api
project_lifecycle: active
knowledge_tier: full
config_source: nacos
config_authority: remote-current
agentmemory_status: verified
codegraph_status: unknown
verification_status: verified
last_verified: 2026-07-29
source_refs:
  - E:\CodeXData\SteelTechnologyNode_api\AGENTS.md
  - E:\CodeXData\SteelTechnologyNode_api\modules\system\AGENTS.md
  - E:\CodeXData\SteelTechnologyNode_api\pom.xml
  - E:\CodeXData\SteelTechnologyNode_api\gateway\src\main\resources\application.yml
  - E:\CodeXData\SteelTechnologyNode_api\modules\system\src\main\resources\application.yml
  - E:\CodeXData\SteelTechnologyNode_api\script\config\nacos\DEFAULT_GROUP\application-common.yml
  - E:\CodeXData\agentMemory\SteelTechnologyNode_api
confidence: EXTRACTED
tags:
  - project
  - SteelTechnologyNode_api
  - Java
  - microservice
---

# SteelTechnologyNode_api

## 项目定位

`SteelTechnologyNode_api` 是以 RuoYi-Cloud-Plus 2.4.1 为基线的 Java 17 微服务后端，使用 Spring Boot 3.4.7、Spring Cloud 2024、MyBatis-Plus、Sa-Token、Dubbo 与 Nacos。

## 模块边界

- `gateway/` 负责网关和全局鉴权，`auth/` 负责认证
- `common/` 提供共享能力，`api/` 定义跨模块契约
- `modules/` 承载业务服务，`script/` 承载 SQL 与配置模板
- `modules/system` 同时承载系统、门户、数据集、材小模及第三方对接；处理该模块时继续读取最近的嵌套 `AGENTS.md`

## 安全与实现约定

- 鉴权、租户和数据权限以本仓 Sa-Token 与 RuoYi 现有实现为准，敏感字段不进入日志、知识库或记忆
- 浏览器入口与流程可写项目规则，账号密码只放仓库外私有位置
- 门户嵌入第三方系统默认由后端生成短期凭证，只返回最小可用用户数据
- 签名不一致先比较完整 `signText` 的精确字节、SHA-256 与首个差异位置，再判断是签名算法还是载荷规范化问题

## Nacos 运行事实

- 目标 Nacos 服务端 namespace/group/dataId 的当前内容是最新运行事实；仓库 `script/config/nacos/DEFAULT_GROUP/**` 是初始化和差异对照模板，客户端 snapshot/cache 只用于事故恢复
- `dev` 与 `local` 都声明为默认 profile，启动和诊断必须显式使用 `-P<profile>`；本仓通过 `${spring.profiles.active}` 选择 namespace
- dev/local 当前定位为 `localhost:30050 / dev / DEFAULT_GROUP`；`kj-prod-110` 使用独立 namespace 与 8848 端口，不得混用 snapshot 或环境判断
- Gateway、Auth 读取 `application-common.yml` 与服务 dataId，业务模块还读取 `datasource.yml`
- 本仓模板中的 `matdao-seata-server` 是跨项目残留风险；远端当前内容未确认前不得发布模板或据此修补 Nacos
- dev snapshot `C:\Users\CxM\nacos\config\Config-fixed-dev-localhost_30050_nacos\` 混有多个项目 dataId，只能定点取证，不得整体复制、清理或视作项目独占事实
- 默认只读；写入必须由用户对精确目标单独授权，并先导出现有配置、记录来源与回滚方案

## 工具与复用入口

- 项目规则：`E:\CodeXData\SteelTechnologyNode_api\AGENTS.md`
- system 细则：`E:\CodeXData\SteelTechnologyNode_api\modules\system\AGENTS.md`
- agentMemory：`agentmemory_steeltechnologynode_api`，当前已有可复用项目记忆
- CodeGraph 状态仍以每次任务的实时检查为准，不从旧桥接页推断
- 旧 `CodeXKnowledge` 只在本页与当前仓库不足时作为历史证据，不再是默认首读入口
