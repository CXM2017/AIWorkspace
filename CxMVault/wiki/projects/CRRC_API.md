---
type: project
status: active
created: 2026-07-16
updated: 2026-07-22
source_refs:
  - E:\CodeXData\CRRC_API\CrrcgcMaterialGene\pom.xml
  - E:\CodeXData\CRRC_API\AGENTS.md
  - E:\CodeXData\CRRC_API\PROJECT_OVERVIEW.md
  - E:\CodeXData\CRRC_API\plans\2026-07-22-crrc-dynamic-dataset-backend-implementation.md
confidence: EXTRACTED
tags:
  - project
  - crrc
  - java
  - spring-boot
  - shiro
  - mybatis-plus
---

# CRRC_API

## 结论

`CRRC_API` 是中车材料基因工程后端，技术基线为 Java 8、Spring Boot 2.7.15、MyBatis-Plus、Druid、Redis、Shiro 和 Knife4j。对应门户端为 [[CRRC_VUE_Index]]，后台管理端为 [[CRRC_VUE_admin]]。

## 模块

- `CrrcgcMaterialGene-base`：共享配置、领域模型、Service、Mapper 与 XML
- `CrrcgcMaterialGene-admin`：管理端启动模块，包含数据库/备份、资源监控和定时任务入口
- `CrrcgcMaterialGene-custom`：定制端启动模块

## 架构与安全

- 认证链路为图形验证码写 Redis -> Shiro 登录 -> Redis Session -> Session ID token
- `/api/**` 与 `/crrc/**` 进入 Session 过期和认证过滤链
- 统一响应为 `RetData`，管理端带 `@ApiOperation` 的成功请求由 AOP 写入访问日志
- MyBatis-Plus 已配置数据权限、分页、乐观锁和防全表更新/删除拦截器

## 2026-07 动态字段改造边界

- 七类旧数据保留数字场景 `0～6` 和旧接口兼容，新增统一数据集服务使用稳定 `sceneCode` 与字段稳定编码
- 存量字段、系统字段以及已创建的自定义字段均不允许修改物理字段名和类型；仅自定义字段可在依赖检查、数据归档成功后删除
- 动态字段必须贯穿列表、详情、查询、表单、导入导出、已保存分析结果和算法输入，不能只改表头展示
- 新表自动发布第一阶段仅支持简单单表；钢材聚合、缺陷图片和复杂关联结构继续使用专用适配器
- 算法字段以明确登记的稳定编码和顺序为准；页面可见字段不等于算法已经支持

## 2026-07-22 后端实现状态

- 后端已完成数据集菜单与Schema、动态CRUD、简单新表、旧表CUSTOM字段登记、自定义字段归档删除、动态导入导出、动态分析和现有算法稳定字段映射
- 后台算法配置位于数据集字段用途配置，不新增模型管理菜单；现有算法固定参数为`spacing`与`fraction`
- DDL操作编号只能重试完全相同的请求；DDL状态使用独立事务，并支持建表成功后补元数据、删列成功后补字段停用
- Base全量61项测试通过，Admin和Custom均打包通过
- 主SQL已执行，但现库7个`creater`字段仍需执行`20260722_dynamic_dataset_metadata_patch.sql`修正为SYSTEM字段
- 当前有效算法映射为0；需业务人员选定两个实际数值候选字段后配置，系统不猜测字段语义

## 环境与工具

- Java 测试文档入口分别为 Custom `33678/crrc/doc.html` 与 Admin `35698/crrc/doc.html`
- 环境账号保存在仓库外私有说明，不写入本页
- CodeGraph 已初始化：675 文件、15,316 节点、23,882 关系
- agentMemory 配置为 `agentmemory_crrc_api`，存储目录 `E:\CodeXData\agentMemory\CRRC_API`
- 数据库 MCP `crrc_test_mysql` 已注册，服务端只允许只读 SQL
- 2026-07-21 已实测 `agentmemory_crrc_api` 返回 1 条架构记忆，`crrc_test_mysql` 的只读 `SELECT 1` 返回成功
- 本地联调已验证门户 `5173`、后台管理 `5174`、Custom `33678`、Admin `35698` 均可访问；当前两个 Vue 代理都指向 Admin `35698/crrc`

## 复用入口

- 本地治理规则：`E:\CodeXData\CRRC_API\AGENTS.md`
- 本地架构说明：`E:\CodeXData\CRRC_API\PROJECT_OVERVIEW.md`
