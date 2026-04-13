# howeverios-edhita - 轻量 iOS 文本编辑器 | Lightweight iOS Text Editor

[![Build](https://github.com/however-yir/howeverios-edhita/actions/workflows/ios-ci.yml/badge.svg)](https://github.com/however-yir/howeverios-edhita/actions/workflows/ios-ci.yml)
[![Docs](https://img.shields.io/badge/docs-README-0A7EFA)](https://github.com/however-yir/howeverios-edhita#readme)
[![License](https://img.shields.io/badge/license-MIT-16A34A)](./LICENSE)
[![Status](https://img.shields.io/badge/status-showcase--ready-2563EB)](https://github.com/however-yir/howeverios-edhita)

🔥 基于 SwiftUI 文本编辑器项目的衍生工程，定位为“轻量编辑 + 可扩展插件 + 工程化治理”的 iOS 应用实践仓库。  
🚀 聚焦 SwiftUI、文件系统、编辑体验、配置治理与发布协作流程。  
⭐ 适合用于 iOS 应用开发学习、编辑器类产品原型孵化、以及个人品牌化二开项目。

> Status: `showcase-ready`
>
> Upstream: `tnantoka/edhita`
>
> 非官方声明（Non-Affiliation）:
> 本仓库为社区维护的衍生项目，与上游项目所属组织或其关联公司无隶属、无官方背书关系。
>
> 商标声明（Trademark Notice）:
> 上游项目名称、Logo 与相关商标归其各自权利人所有；本仓库仅用于兼容性与来源说明，不主张其商标权。
>
> Attribution: upstream license remains in `LICENSE`; fork boundary and redistribution notes are maintained in `LICENSE.HOWEVER` and `NOTICE.md`.
>
> Series: [howeverandroid-architecture-lab](https://github.com/however-yir/howeverandroid-architecture-lab)

![howeverios-edhita showcase cover](docs/showcase/portfolio-cover.svg)

## 目录

- [1. 项目概述](#1-项目概述)
- [2. 背景与目标](#2-背景与目标)
- [3. 架构与能力边界](#3-架构与能力边界)
- [4. 当前改造内容](#4-当前改造内容)
- [5. 功能全景](#5-功能全景)
- [6. 技术栈说明](#6-技术栈说明)
- [7. 仓库结构](#7-仓库结构)
- [8. 快速开始](#8-快速开始)
- [9. 配置与签名说明](#9-配置与签名说明)
- [10. 测试与质量保障](#10-测试与质量保障)
- [11. 二次开发建议](#11-二次开发建议)
- [12. 与上游差异](#12-与上游差异)
- [13. 贡献方式](#13-贡献方式)
- [14. License](#14-license)

## 1. 项目概述

`howeverios-edhita` 基于 `tnantoka/edhita` 进行衍生改造，目标是保留上游“轻量文本编辑器”的清晰体验，同时引入品牌化、配置化与工程治理能力，使其更适合作为长期维护的 iOS 产品雏形。

## 2. 背景与目标

编辑器类 iOS 项目在演示层面通常很完整，但在“团队协作与持续发布”上常缺少以下资产：

1. 可直接复用的 Bundle ID / 签名规范。
2. 本地与生产环境分离的配置模板。
3. 衍生项目差异文档与治理策略。
4. 上游同步脚本与冲突处理流程。

本仓库通过首轮改造补齐这些基础设施。

## 3. 架构与能力边界

核心能力仍基于 SwiftUI + 文件系统读写，当前保持“轻量编辑器”定位：

- 文本文件浏览与编辑。
- 基础设置与字体参数管理。
- iOS 原生交互与系统能力接入。

当前边界：

- 暂不引入重型协作服务端。
- 暂不引入复杂账号体系。
- 先保证本地编辑体验稳定，再扩展云同步。

## 4. 当前改造内容

1. 主 Target Bundle ID 改为 `com.howeveryir.howeveriosedhita`。
2. 测试 Target Bundle ID 同步改造。
3. Team ID 替换为占位 `YOURTEAMID123`。
4. App 显示名改为 `HoweverEdhita`。
5. AdMob App ID 改为占位值，避免提交真实标识。
6. 示例内容中的品牌与链接切换为 fork 仓库。
7. 新增环境配置模板 `Config/Environment.sample.xcconfig`。
8. 新增衍生协议说明 `LICENSE.HOWEVER`。
9. 新增上游同步脚本 `scripts/sync_upstream.sh`。
10. 新增改造说明与 50 点路线文档。

## 5. 功能全景

当前可用能力包括：

- 文件列表浏览与目录切换。
- 文本编辑与基础预览。
- 设置面板与字体偏好。
- 系统分享与辅助视图能力。
- iPhone/iPad 形态下的基础适配。

### 5.1 展示首屏建议

当前仓库尚未提交真实设备或模拟器截图。为了让首页更像完整作品集，建议优先补齐以下 4 组演示素材：

| 场景 | 推荐展示内容 | 建议文件名 | 用途 |
|---|---|---|---|
| 冷启动与文件列表 | App 图标、目录列表、品牌化名称 | `docs/showcase/launch-list.png` | README 首屏静态图 |
| 编辑主界面 | 打开示例文件并展示编辑区域 | `docs/showcase/editor-main.png` | 功能证明图 |
| 设置与字体偏好 | 字体大小、主题或偏好项切换 | `docs/showcase/settings.png` | 配置能力展示 |
| 交互录屏 | 浏览目录、编辑文本、分享文件 | `docs/showcase/editor-flow.mov` | 招聘/作品集演示视频 |

## 6. 技术栈说明

- Swift
- SwiftUI
- Xcode Project
- Swift Package Manager
- iOS 原生文件系统 API

## 7. 仓库结构

```text
.
├── Edhita/
├── Edhita.xcodeproj/
├── Config/
│   └── Environment.sample.xcconfig
├── docs/
│   ├── HOWEVER_DELTA.md
│   └── DERIVATIVE_50POINT_PLAN.zh-CN.md
├── scripts/
│   └── sync_upstream.sh
├── LICENSE
├── LICENSE.HOWEVER
└── README.md
```

## 8. 快速开始

1. 克隆项目：

```bash
git clone https://github.com/however-yir/howeverios-edhita.git
cd howeverios-edhita
```

2. 按需复制配置：

```bash
cp Config/Environment.sample.xcconfig Config/Environment.local.xcconfig
```

3. 打开工程并运行：

```bash
open Edhita.xcodeproj
```

## 9. 配置与签名说明

- `PRODUCT_BUNDLE_IDENTIFIER` 已切换为 fork 命名。
- `DEVELOPMENT_TEAM` 为占位值，需替换为你自己的 Team ID。
- 广告与外部服务标识建议全部使用占位/环境注入。

### 9.1 Bundle ID 与签名检查表

| 配置项 | 当前默认值 | 使用前动作 | 说明 |
|---|---|---|---|
| `PRODUCT_BUNDLE_IDENTIFIER` | `com.howeveryir.howeveriosedhita` | 按团队命名规范替换 | 避免与其他 App 或历史包名冲突 |
| `DEVELOPMENT_TEAM` | `YOURTEAMID123` | 替换为真实 Team ID | 否则无法正常签名运行 |
| `App Display Name` | `HoweverEdhita` | 视品牌需要微调 | 保持 README、截图与安装包名称一致 |
| `Config/Environment.local.xcconfig` | 本地复制生成 | 填入本地调试配置 | 不要提交真实敏感标识 |
| 广告/外部服务 ID | 占位值 | 仅在发布环境注入 | 避免把真实 ID 留在公开仓库 |

### 9.2 录屏与截图脚本建议

建议在演示素材中稳定覆盖以下顺序：

1. 从文件列表进入一个示例 Markdown 或文本文件。
2. 展示编辑、滚动与基础设置切换。
3. 展示分享或文件导出路径。
4. 结束在设置页或品牌化首页，形成完整的“轻量编辑器产品感”。

## 10. 测试与质量保障

建议执行：

- 单元测试
- UI 测试
- 关键路径手工回归（新建、编辑、保存、预览）

建议在 CI 增加：

- 构建检查
- 静态分析
- 依赖审计

## 11. 二次开发建议

- 先补齐文档与测试，再做功能大改。
- 将编辑核心能力与展示层继续解耦。
- 增加插件化入口，降低后续扩展成本。

## 12. 与上游差异

请查看：

- `docs/HOWEVER_DELTA.md`
- `docs/DERIVATIVE_50POINT_PLAN.zh-CN.md`

差异摘要可先按下表理解：

| 维度 | Upstream Edhita | howeverios-edhita |
|---|---|---|
| 品牌层 | 保持上游命名 | 切换到 `HoweverEdhita` 品牌语义 |
| 包名与签名 | 上游默认工程配置 | 补齐 Bundle ID 与 Team ID 占位治理 |
| 配置管理 | 以工程默认值为主 | 新增 `Config/Environment.sample.xcconfig` |
| 协作治理 | 偏上游项目语境 | 增加 `LICENSE.HOWEVER`、路线图与同步脚本 |
| 作品集展示 | 以功能可用为主 | 更强调 README、截图位和品牌化演示资产 |

## 13. 贡献方式

欢迎通过 Issue / PR 参与改进，提交建议包含：

- 变更背景
- 实现说明
- 验证步骤
- 风险与兼容性评估

## 14. License

- 上游代码遵循 MIT。
- 衍生说明见 `LICENSE.HOWEVER`。
- 分发边界与 fork 归属说明见 `NOTICE.md`。