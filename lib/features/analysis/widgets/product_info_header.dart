import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class ProductInfoHeader extends StatelessWidget {
  const ProductInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, size: 48),
              ),
            ),
            const SizedBox(height: 12),
            Text('Organic Almond Milk 1 L', style: text.headlineSmall),
            const SizedBox(height: 4),
            Text('Barcode: 1234567890123', style: text.bodyMedium),
            Text('Scanned: 30 Jul 2025', style: context.textStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
