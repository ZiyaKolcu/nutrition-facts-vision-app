import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class RiskChart extends StatelessWidget {
  const RiskChart({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nutrient Breakdown', style: text.titleMedium),
            const SizedBox(height: 12),
            _NutrientBar(label: 'Protein', value: 6, max: 20),
            _NutrientBar(label: 'Sugar', value: 2, max: 20),
            _NutrientBar(label: 'Fat', value: 3, max: 20),
            _NutrientBar(label: 'Fiber', value: 1, max: 20),
          ],
        ),
      ),
    );
  }
}

class _NutrientBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;

  const _NutrientBar({
    required this.label,
    required this.value,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: text.bodySmall)),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: value / max,
              color: colors.primary,
              backgroundColor: colors.surfaceContainerHighest,
            ),
          ),
          const SizedBox(width: 8),
          Text('$value g', style: text.bodySmall),
        ],
      ),
    );
  }
}
