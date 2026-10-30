/// 统一错误分类：UI 只展示 [userMessage]，不解析底层异常。
enum AppErrorKind {
  validation,
  config,
  network,
  ai,
  storage,
  consistency,
  backup,
  permission,
  unknown,
}

class AppError implements Exception {
  const AppError(
    this.kind,
    this.message, {
    this.cause,
    this.stackTrace,
  });

  final AppErrorKind kind;
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  String get userMessage {
    switch (kind) {
      case AppErrorKind.validation:
        return '内容不完整或格式不正确，请检查后重试。';
      case AppErrorKind.config:
        return '请先在设置中完成 AI 配置。';
      case AppErrorKind.network:
        return '网络不可用，请检查网络后重试。';
      case AppErrorKind.ai:
        return '识别失败，可重试或改为手动录入。';
      case AppErrorKind.storage:
        return '存储空间不足或写入失败，请重试。';
      case AppErrorKind.consistency:
        return '数据状态异常，请稍后重试或运行修复。';
      case AppErrorKind.backup:
        return '备份/恢复失败，原数据未被修改。';
      case AppErrorKind.permission:
        return '权限不足，请在系统设置中开启。';
      case AppErrorKind.unknown:
        return '发生未知错误，请重试。';
    }
  }

  @override
  String toString() => 'AppError($kind): $message';
}

/// 轻量结果类型：避免异常穿透到 UI。
sealed class AppResult<T> {
  const AppResult();
}

final class Ok<T> extends AppResult<T> {
  const Ok(this.value);
  final T value;
}

final class Err<T> extends AppResult<T> {
  const Err(this.error);
  final AppError error;
}
