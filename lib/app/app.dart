import 'package:flutter/material.dart';

import '../presentation/shell/home_shell.dart';

class MathRecallApp extends StatelessWidget {
  const MathRecallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathRecall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1565C0),
      ),
      home: const HomeShell(),
    );
  }
}
