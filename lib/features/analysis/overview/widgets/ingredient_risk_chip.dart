import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_extensions.dart';

class IngredientRiskChip extends StatelessWidget {
  final String name;
  final String level;
  const IngredientRiskChip({
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

    return Chip(
      label: Text(name, style: text.bodyMedium),
      backgroundColor: Colors.transparent,
      side: BorderSide(color: color, width: 2),
      shape: const StadiumBorder(),
      labelStyle: TextStyle(color: color),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    );
  }
}
