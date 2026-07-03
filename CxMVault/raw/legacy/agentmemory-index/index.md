---
type: memory-bridge
status: active
created: 2026-07-02
updated: 2026-07-02
source_refs:
  - E:\CodeXData\agentMemory
confidence: EXTRACTED
tags:
  - legacy
  - agentmemory
  - migration
---

# agentMemory 旧项目记忆桥接

## 结论

`E:\CodeXData\agentMemory` 不迁移、不删除、不改写。`CxMVault` 通过本索引提示后续 agent：处理旧项目时仍需读取对应项目的原 agentMemory，避免因为新 vault 初始化而丢失已沉淀的排错路径和执行偏好。

## 项目记忆入口

- `damaihelper-main`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\damaihelper-main`
- `MatDao`：9 个记忆文件，旧路径 `E:\CodeXData\agentMemory\MatDao`
- `matdao_api`：9 个记忆文件，旧路径 `E:\CodeXData\agentMemory\matdao_api`
- `matdao-web-index`：5 个记忆文件，旧路径 `E:\CodeXData\agentMemory\matdao-web-index`
- `MyDIY`：7 个记忆文件，旧路径 `E:\CodeXData\agentMemory\MyDIY`
- `MyExcel`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\MyExcel`
- `Ngrok`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\Ngrok`
- `portal-login-test`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\portal-login-test`
- `SteelNodeManage_admin`：5 个记忆文件，旧路径 `E:\CodeXData\agentMemory\SteelNodeManage_admin`
- `SteelProblems`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\SteelProblems`
- `SteelTechnologyNode_api`：9 个记忆文件，旧路径 `E:\CodeXData\agentMemory\SteelTechnologyNode_api`
- `yudao-cloud`：1 个记忆文件，旧路径 `E:\CodeXData\agentMemory\yudao-cloud`

## 使用规则

- 处理 `E:\CodeXData` 下旧项目任务时，先查新库 `wiki/projects/<项目名>.md`，再查对应旧 `agentMemory/<项目名>`
- 若旧 memory 中的经验仍有效，应在完成任务后择要编译为 `CxMVault` 的 wiki 页面
- 不写入密钥、Token、密码、私钥、测试账号或完整敏感请求体
- `.tmp` 目录只作为历史系统数据，不作为常规检索入口
