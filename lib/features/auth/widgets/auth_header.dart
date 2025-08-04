import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;

    return Column(
      children: [
        Icon(Icons.account_circle, size: 72, color: context.colors.primary),
        const SizedBox(height: 12),
        Text(title, style: text.headlineMedium),
        const SizedBox(height: 4),
        Text(subtitle, style: text.bodyMedium),
      ],
    );
  }
}
