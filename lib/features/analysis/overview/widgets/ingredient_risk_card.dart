import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_extensions.dart';

class IngredientRiskCard extends StatelessWidget {
  final String name;
  final String level;
  const IngredientRiskCard({
    super.key,
    required this.name,
    required this.level,
  });

  Color _color(BuildContext context) {
    switch (level) {
      case 'High':
        return AppColors.error;
      case 'Medium':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    final color = _color(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(Icons.warning, color: color),
        ),
        title: Text(name, style: text.bodyLarge),
        trailing: Chip(
          label: Text(level, style: text.labelSmall),
          backgroundColor: color.withValues(alpha: .2),
          labelStyle: TextStyle(color: color),
        ),
      ),
    );
  }
}
