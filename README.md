# AIWorkspace

This repository stores the private `CxMVault` knowledge base used by local agents and Obsidian.

## Entry Points

- [CxMVault/README.md](CxMVault/README.md): vault overview
- [CxMVault/00-开始使用.md](CxMVault/00-%E5%BC%80%E5%A7%8B%E4%BD%BF%E7%94%A8.md): daily usage guide
- [CxMVault/wiki/index.md](CxMVault/wiki/index.md): wiki index
- [CxMVault/schema/AGENTS.md](CxMVault/schema/AGENTS.md): agent maintenance contract

## Repository Policy

This is a private repository. Raw inbox material under `CxMVault/raw/` is intentionally versioned so it can be traced and compiled into stable wiki pages later.

The repository does not version local runtime state, generated reports, maintenance logs, or installed Obsidian plugin code. Those paths are ignored in `.gitignore`.

## Health Check

Run the vault health check before publishing structural changes:

```powershell
& 'E:\AIWorkspace\CxMVault\tools\Test-CxMVault.ps1'
```
