import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/screens/auth_gate.dart';
import 'core/theme/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final isDark = brightness == Brightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const AuthGate(), 
    );
  }
}
