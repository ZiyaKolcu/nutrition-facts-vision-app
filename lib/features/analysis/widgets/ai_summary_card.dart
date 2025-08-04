import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class AiSummaryCard extends StatelessWidget {
  const AiSummaryCard({super.key});

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
            Text(
              'Overall a healthy choice. Low sugar, fortified with calcium & vitamin D. '
              'Minor concern: carrageenan may cause sensitivity in some users.',
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
