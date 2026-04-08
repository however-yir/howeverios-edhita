# howeverios-edhita 改造说明

## 首轮改造已完成

1. Bundle ID 调整为 `com.howeveryir.howeveriosedhita`。
2. 测试 Target Bundle ID 同步调整。
3. Team ID 改为占位值 `YOURTEAMID123`。
4. `CFBundleDisplayName` 改为 `HoweverEdhita`。
5. AdMob App ID 改为占位值。
6. 示例内容中的品牌与仓库链接替换为 fork 版本。
7. 新增环境配置样例 `Config/Environment.sample.xcconfig`。
8. 新增衍生协议说明 `LICENSE.HOWEVER`。
9. 新增上游同步脚本 `scripts/sync_upstream.sh`。

## 后续建议

- 增加 iCloud 同步与冲突合并策略。
- 增加文档预览插件扩展能力。
- 增加 iPad 场景下多窗口编辑体验优化。
