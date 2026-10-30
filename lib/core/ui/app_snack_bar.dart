import 'package:flutter/material.dart';

/// 统一 SnackBar：先清空当前队列再显示，避免连续点击时提示叠加/排队。
extension AppSnackBar on ScaffoldMessengerState {
  void showMessage(
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 2),
  }) {
    clearSnackBars();
    showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration,
      ),
    );
  }
}
