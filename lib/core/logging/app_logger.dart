import 'dart:developer' as developer;

/// 本地日志：统一入口、可脱敏；后续可扩展文件落盘。
class AppLogger {
  const AppLogger(this.name);

  final String name;

  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: name, level: 500, error: error, stackTrace: stackTrace);
  }

  void info(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: name, level: 800, error: error, stackTrace: stackTrace);
  }

  void warn(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: name, level: 900, error: error, stackTrace: stackTrace);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: name, level: 1000, error: error, stackTrace: stackTrace);
  }
}
