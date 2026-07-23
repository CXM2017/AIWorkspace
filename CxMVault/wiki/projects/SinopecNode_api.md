---
type: project
status: active
created: 2026-07-23
updated: 2026-07-23
source_refs:
  - E:\CodeXData\SinopecNode_api
  - E:\CodeXData\SteelTechnologyNode_api
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

- `sinopecnode-gateway`：网关，默认端口 32000
- `sinopecnode-auth`：认证中心，默认端口 32001
- `sinopecnode-system`：系统管理，默认端口 32002
- `sinopecnode-portal`：前台门户独立服务，默认端口 32003
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

## 初始化脚本

MySQL 初始化顺序：

1. `script/sql/sinopecnode-databases.sql`
2. `script/sql/sinopecnode-cloud.sql`
3. `script/sql/sinopecnode-system-extension.sql`
4. `script/sql/sinopecnode-portal.sql`
5. job、workflow、config、seata 对应脚本

门户脚本只包含门户表结构，不写入原参考项目的钢铁业务示例数据。

## 已验证基线

- portal 单元测试：27 项，0 失败、0 错误、0 跳过
- Maven Reactor：58 个模块全量打包成功
- system 中门户路由文件：0
- portal 中 `/portal/**` Controller：5 个，后台模型管理入口另保留细粒度权限注解
- 敏感配置字面量审计：0
- 旧项目标识残留审计：0

## 后续任务入口

- 先读项目根 `README.md`
- 项目治理规则见根 `AGENTS.md`
- system 和 portal 的边界分别见 `modules/system/AGENTS.md`、`modules/portal/AGENTS.md`
- 门户环境变量与接口说明见 `docs/api/`

