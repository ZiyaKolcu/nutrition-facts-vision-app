import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class AiSummaryCard extends StatelessWidget {
  final String summary;
  const AiSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Card(
      color: colors.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Health Summary', style: text.titleMedium),
            const SizedBox(height: 8),
            Text(summary, style: text.bodyMedium),
          ],
        ),
      ),
    );
  }
}
