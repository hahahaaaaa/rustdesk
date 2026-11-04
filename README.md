# VoltMonkey

基于 [RustDesk](https://github.com/rustdesk/rustdesk) 1.5.1 定制的远程桌面客户端，默认连接自建服务器 `desktop.voltmonkey.com.cn`；配套服务端见 [rustdesk-server 分支](https://github.com/hahahaaaaa/rustdesk-server)。

本仓库是下游定制分支，不是官方发行版；上游功能与文档以官方仓库为准。

## 改了什么

- **品牌**：桌面端与移动端界面文字改为 VoltMonkey；Android/iOS 包名改为 `com.voltmonkey.remote`，应用名改为 VoltMonkey，避免与官方 RustDesk 互相覆盖安装、也不被系统的远程控制软件安装拦截命中。
- **主题**：全部页面换成 Vercel / Geist 风格（`flutter/lib/common/vercel_theme.dart`、`DESIGN.md`），浅色深色各一套色板。
- **默认服务器**：`src/common.rs` 与 `flutter/lib/common.dart` 中的 ID / API 地址改为 `desktop.voltmonkey.com.cn`。
- **移动端图标**：换成黑底白 V 的启动图标与通知小图标（`mipmap-*`、`AppIcon.appiconset`、`flutter/assets/icon.svg`）。
- **CI**：新增 `.github/workflows/flutter-ci.yml`，push main 即构建全平台；Windows arm64 用 Flutter 3.44.9 + 源码补丁，其余平台仍是 3.24.5。

## 桌面图标为什么还是 RustDesk 的

桌面端图标文件没有被替换：`res/icon.png`、`res/icon.ico`、`res/tray-icon.ico`、`res/mac-icon.png`、`res/scalable.svg`、`flutter/windows/runner/resources/app_icon.ico` 与上游 1.5.1 **逐字节相同**（md5 一致）。

原因：

1. 这些图标在**构建期**被写进 exe / MSI / .app / .desktop，改 SVG 或改主题都不会生效；
2. `.ico` / `.icns` 是多尺寸二进制容器，必须从源图重新生成（`res/gen_icon.sh` 依赖 ImageMagick，icns 要 `iconutil`），这次没做，`res/icon.png` 源图本身也还是旧标；
3. 图标分散在 6 个引用点、各平台各一套：`build.rs`（exe）、`Runner.rc`（窗口/任务栏）、`src/tray.rs`（托盘）、`build.py`、`res/*.spec`、`appimage/AppImageBuilder-*.yml`，漏一处系统仍显示旧图标；
4. 桌面端产品名也没改：`Runner.rc` 的 `ProductName` 是 RustDesk，`main.cpp` 的 `app_name` 是 RustDesk，`res/rustdesk.desktop` 里 `Name=RustDesk`。

补齐需要替换：`res/icon.png`（1024 源图）→ 生成 `res/32x32.png`、`64x64.png`、`128x128.png`、`128x128@2x.png`、`res/scalable.svg`、`res/icon.ico`、`res/tray-icon.ico`、`flutter/windows/runner/resources/app_icon.ico`、`flutter/macos/Runner/AppIcon.icns`、`res/mac-icon.png`。

## 构建

```bash
cargo run                    # Rust 核心调试
python build.py --flutter    # Flutter 桌面端打包（Linux deb/rpm、macOS dmg，MSI 由 CI 生成）
```

依赖 Rust、vcpkg、Flutter 3.24.5（Windows arm64 用 3.44.9）。也可以直接跑 CI 拿全平台产物。

## 许可证

AGPL-3.0，与上游一致，见 [LICENCE](LICENCE)。
