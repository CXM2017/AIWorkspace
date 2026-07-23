---
type: runbook
status: active
created: 2026-07-10
updated: 2026-07-16
source_refs:
  - D:\CodeX\conversations\chrome-extension-repair-20260710\repair.log
  - D:\CodeX\conversations\chrome-extension-repair-20260710\plugin-reinstall.log
  - D:\CodeX\backups\chrome-native-host-config-20260710-0912-after-vendor-fix
  - D:\CodeX\maintenance\Repair-CodexChromeNativeHost.ps1
  - D:\CodeX\maintenance\Register-CodexChromeNativeHostRepairTask.ps1
  - C:\Users\CxM\Desktop\修复 ChatGPT Chrome 扩展.cmd
  - D:\CodeX\logs\codex-chrome-native-host
confidence: EXTRACTED
tags:
  - codex
  - chrome
  - native-host
  - windows
  - runbook
---

# Codex Chrome 扩展 Native Host 修复

## 适用症状

Chrome 侧边栏 ChatGPT 扩展报错：

- `Codex app-server manifest entry is missing required path codexCliPath`
- `Codex Chrome native host v2 manifest is missing`
- `The Chrome side panel could not connect to the ChatGPT desktop app`

本次机器环境：Windows，ChatGPT/Codex Desktop 包版本会随商店自动更新漂移，Chrome 扩展 ID `hehggadaopoacecdllhhajmbjkdcmajg`。

## 结论：优先使用永久化修复脚本

不要再手工写死某个版本的 `codexCliPath`、`nodePath`、`nodeReplPath` 或 `resourcesPath`。桌面端自动更新后，`OpenAI.Codex_<version>`、运行时 hash 目录和 bundled Chrome 插件版本都会变化，一次性 manifest 会再次失效。

当前机器的固定入口：

```powershell
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File 'D:\CodeX\maintenance\Repair-CodexChromeNativeHost.ps1'
```

默认不启用高频轮询。出现报错时，双击桌面的 `修复 ChatGPT Chrome 扩展.cmd`；它会调用同一份修复脚本并保留窗口显示结果。

若希望每次登录 Windows 自动检查一次（可选，而不是默认），才注册登录触发任务：

```powershell
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File 'D:\CodeX\maintenance\Register-CodexChromeNativeHostRepairTask.ps1'
schtasks.exe /Query /TN CodexChromeNativeHostRepair /FO LIST
```

取消登录触发任务：

```powershell
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File 'D:\CodeX\maintenance\Register-CodexChromeNativeHostRepairTask.ps1' -Mode Remove
```

修复脚本会自动检测当前 AppX 包、当前 bundled Chrome 插件版本、当前 `D:\CodeX\runtimes\desktop-bin\<hash>\codex.exe`、当前 C 盘桌面端 node runtime，并在版本漂移或路径缺失时重建：

- `D:\CodeX\.codex\vendor_imports\openai-bundled`
- `D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\latest`
- `C:\Users\CxM\AppData\Local\OpenAI\extension\com.openai.codexextension.json`
- `D:\CodeX\.codex\chrome-native-hosts-v2.json`
- `C:\Users\CxM\AppData\Local\OpenAI\Codex\chrome-native-hosts-v2.json`

日志位置：

```text
D:\CodeX\logs\codex-chrome-native-host\repair-YYYYMMDD.log
```

## 快速判断

优先查这些点，不要一开始重装 Chrome 或重置桌面端数据。

```powershell
$codex = 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\codex.exe'
& $codex plugin list | Select-String -Pattern 'chrome@openai-bundled|openai-bundled' -Context 0,8
```

如果 `chrome@openai-bundled` 版本低于当前桌面包内自带版本，先同步 `vendor_imports`。

```powershell
Get-Content 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\plugins\openai-bundled\plugins\chrome\.codex-plugin\plugin.json' -Raw | ConvertFrom-Json | Select-Object name,version
Get-Content 'D:\CodeX\.codex\vendor_imports\openai-bundled\plugins\chrome\.codex-plugin\plugin.json' -Raw | ConvertFrom-Json | Select-Object name,version
```

检查 C 盘迁移状态时要区分目录语义：

- `C:\Users\CxM\AppData\Local\OpenAI\Codex\bin` 应该是 junction，目标是 `D:\CodeX\runtimes\desktop-bin`
- 不要把整个 `C:\Users\CxM\AppData\Local\OpenAI\Codex` 直接 junction 到 `D:\CodeX\.codex`
- `C:\Users\CxM\AppData\Local\OpenAI\Codex` 是桌面端 runtime/config 目录，`D:\CodeX\.codex` 是 Codex Home，二者不是同一个目录

## 根因

2026-07-10 的根因是版本链断裂：

- 桌面端已升级到 `26.707`
- `D:\CodeX\.codex\vendor_imports\openai-bundled` 仍停在旧版 `26.602`
- Chrome 插件缓存和 `latest` junction 未正确指向新版
- v2 manifest 指向旧的 `codexCliPath`、`nodePath`、`resourcesPath`
- 旧 hash 目录已不存在，导致侧边栏报 `codexCliPath` 缺失或 v2 manifest 缺失

2026-07-16 复发的根因是同类问题：桌面端已升级到 `OpenAI.Codex_26.707.9981.0_x64__2p2nqsd0c76g0`，但 v2 manifest 仍指向 2026-07-10 的旧 AppX 版本和旧运行时 hash。永久修复不是再次手工改 JSON，而是让脚本在桌面端更新后按需重建 native host 配置。默认采取手动一键修复；不再使用每 10 分钟轮询。

## 修复流程

先备份旧 vendor import。

```powershell
$src = 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\plugins\openai-bundled'
$dst = 'D:\CodeX\.codex\vendor_imports\openai-bundled'
$backup = 'D:\CodeX\backups\openai-bundled-vendor-20260710-0909'
robocopy $dst $backup /MIR /R:1 /W:1 /NFL /NDL /NP
robocopy $src $dst /MIR /R:1 /W:1 /NFL /NDL /NP
```

重新安装 Chrome bundled 插件。

```powershell
$codex = 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\codex.exe'
Get-Process -Name extension-host -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
& $codex plugin remove 'chrome@openai-bundled' --json
& $codex plugin add 'chrome@openai-bundled' --json
```

确认安装结果应类似：

```text
"version": "26.707.31123"
"installedPath": "D:\\CodeX\\.codex\\plugins\\cache\\openai-bundled\\chrome\\26.707.31123"
```

修复 `latest` junction。

```powershell
$link = 'D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\latest'
$target = 'D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\26.707.31123'
if (-not (Test-Path -LiteralPath $link)) {
  New-Item -ItemType Junction -Path $link -Target $target | Out-Null
}
```

生成标准 native host manifest 和 `extension-host-config.json`。优先让桌面端插件 UI 触发安装；若 UI 失败且已确认路径，使用插件包自带脚本生成。

```powershell
$node = 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\cua_node\bin\node.exe'
$script = @'
const installer = await import('file:///D:/CodeX/.codex/plugins/cache/openai-bundled/chrome/26.707.31123/scripts/installManifest.mjs');
await installer.install({
  appServerRuntimePaths: {
    codexCliPath: String.raw`C:\Users\CxM\AppData\Local\OpenAI\Codex\bin\a7c12ebff69fb123\codex.exe`,
    nodePath: String.raw`C:\Users\CxM\AppData\Local\OpenAI\Codex\runtimes\cua_node\ecfc0d9aa02807e3\bin\node.exe`,
    nodeReplPath: String.raw`C:\Users\CxM\AppData\Local\OpenAI\Codex\runtimes\cua_node\ecfc0d9aa02807e3\bin\node_repl.exe`,
  },
});
console.log(JSON.stringify({ ok: true }, null, 2));
'@
$script | & $node --input-type=module
```

补齐 v2 manifest。可从备份的旧 v2 JSON 复制结构，替换为当前真实路径：

- `browserClientPath`: `D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\latest\scripts\browser-client.mjs`
- `codexCliPath`: `C:\Users\CxM\AppData\Local\OpenAI\Codex\bin\a7c12ebff69fb123\codex.exe`
- `extensionHostPath`: `D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\latest\extension-host\windows\x64\extension-host.exe`
- `nodePath`: `C:\Users\CxM\AppData\Local\OpenAI\Codex\runtimes\cua_node\ecfc0d9aa02807e3\bin\node.exe`
- `nodeReplPath`: `C:\Users\CxM\AppData\Local\OpenAI\Codex\runtimes\cua_node\ecfc0d9aa02807e3\bin\node_repl.exe`
- `resourcesPath`: `C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources`

写入两份：

```text
D:\CodeX\.codex\chrome-native-hosts-v2.json
C:\Users\CxM\AppData\Local\OpenAI\Codex\chrome-native-hosts-v2.json
```

## 验证

检查 native host manifest。

```powershell
& 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\cua_node\bin\node.exe' `
  'D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\26.707.31123\scripts\check-native-host-manifest.js' --json
```

期望：

```text
"correct": true
"problem": null
```

检查 Chrome 扩展安装状态。

```powershell
& 'C:\Program Files\WindowsApps\OpenAI.Codex_26.707.3563.0_x64__2p2nqsd0c76g0\app\resources\cua_node\bin\node.exe' `
  'D:\CodeX\.codex\plugins\cache\openai-bundled\chrome\26.707.31123\scripts\check-extension-installed.js' --json
```

期望：

```text
"installed": true
"enabled": true
```

最后做实际连接验证：用 Chrome 插件 runtime 获取 `browser.documentation()` 和 `browser.user.openTabs()`。本次结果：

```json
{
  "ok": true,
  "docsLength": 40906,
  "openTabsCount": 1
}
```

## 回滚

本次保留了两个关键备份：

- `D:\CodeX\backups\openai-bundled-vendor-20260710-0909`
- `D:\CodeX\backups\chrome-native-host-config-20260710-0912-after-vendor-fix`

需要回滚时，先关闭 ChatGPT/Codex Desktop 和 `extension-host.exe`，再恢复对应文件。不要删除 `C:\Users\CxM\AppData\Local\OpenAI\Codex` 整个目录；其中有桌面端 runtime 与状态。
