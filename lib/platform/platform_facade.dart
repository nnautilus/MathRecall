import 'dart:typed_data';

/// 图片来源（业务层不依赖具体插件）。
enum PickSource { camera, gallery }

/// 平台能力抽象：相机/相册、分享、网络状态等。
///
/// 业务层只依赖本接口；插件实现位于 infrastructure/platform。
abstract interface class PlatformFacade {
  Future<Uint8List?> pickImage(PickSource source);

  Future<void> shareFile(String path);

  Future<bool> isOnline();
}

/// 测试/占位实现：不触发系统能力。
class FakePlatformFacade implements PlatformFacade {
  @override
  Future<Uint8List?> pickImage(PickSource source) async => null;

  @override
  Future<void> shareFile(String path) async {}

  @override
  Future<bool> isOnline() async => true;
}
