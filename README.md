# VoltMonkey

基于 [RustDesk](https://github.com/rustdesk/rustdesk) 1.5.1 定制的远程桌面客户端，默认连接自建服务器 `desktop.voltmonkey.com.cn`；配套服务端见 [rustdesk-server 分支](https://github.com/hahahaaaaa/rustdesk-server)。

本仓库是下游定制分支，不是官方发行版；上游功能与文档以官方仓库为准。

## 改了什么

- **品牌**：桌面端与移动端界面文字改为 VoltMonkey；Android/iOS 包名改为 `com.voltmonkey.remote`，应用名改为 VoltMonkey，避免与官方 RustDesk 互相覆盖安装、也不被系统的远程控制软件安装拦截命中。
- **主题**：全部页面换成 Vercel / Geist 风格（`flutter/lib/common/vercel_theme.dart`、`DESIGN.md`），浅色深色各一套色板。
- **默认服务器与密钥**：`src/common.rs` / `flutter/lib/common.dart` 中的 ID / API 地址改为 `desktop.voltmonkey.com.cn`，服务端公钥内置在 `src/common.rs` 的 `EMBEDDED_PUB_KEY`（也可用构建变量 `VOLTMONKEY_PUB_KEY` 注入），首次启动写入 `key` 选项，客户端连自建服务不用手填密钥。
- **图标**：统一换成黑底白 V。移动端用 `mipmap-*` / `AppIcon.appiconset`，桌面端重新生成了 `res/icon.ico`（exe 与 MSI）、`flutter/windows/runner/resources/app_icon.ico`（窗口/任务栏/快捷方式）、`res/tray-icon.ico`、`res/32~128@2x.png`、`res/scalable.svg`、`flutter/macos/Runner/AppIcon.icns`、`res/mac-tray-*.png`。
- **CI**：新增 `.github/workflows/flutter-ci.yml`，push main 即构建全平台；Windows arm64 用 Flutter 3.44.9 + 源码补丁，其余平台仍是 3.24.5。

## 构建

```bash
cargo run                    # Rust 核心调试
python build.py --flutter    # Flutter 桌面端打包（Linux deb/rpm、macOS dmg，MSI 由 CI 生成）
```

依赖 Rust、vcpkg、Flutter 3.24.5（Windows arm64 用 3.44.9）。也可以直接跑 CI 拿全平台产物。

## 许可证

AGPL-3.0，与上游一致，见 [LICENCE](LICENCE)。
