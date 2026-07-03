# AIWorkspace

本仓库用于保存私有知识库 `CxMVault`，供本机 Agent 和 Obsidian 共同使用。

## 入口

- [CxMVault/README.md](CxMVault/README.md)：知识库总览
- [CxMVault/00-开始使用.md](CxMVault/00-%E5%BC%80%E5%A7%8B%E4%BD%BF%E7%94%A8.md)：日常使用入口
- [CxMVault/wiki/index.md](CxMVault/wiki/index.md)：Wiki 索引
- [CxMVault/schema/AGENTS.md](CxMVault/schema/AGENTS.md)：Agent 维护契约

## 仓库策略

这是私有仓库。`CxMVault/raw/` 下的原始收件箱资料会纳入版本管理，便于后续追溯来源并编译成稳定 Wiki 页面。

仓库不纳入本机界面状态、生成报告、维护日志和已安装的 Obsidian 插件代码；这些路径由 `.gitignore` 忽略。

Obsidian Git 插件的配置文件会纳入版本管理，但插件代码本身不纳入版本管理。插件认证仍使用本机 Git / Git Credential Manager / GitHub CLI，不把凭据写入仓库。

## 健康检查

发布结构性变更前运行：

```powershell
& 'E:\AIWorkspace\CxMVault\tools\Test-CxMVault.ps1'
```
