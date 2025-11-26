import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../models/scan_detail_model.dart';

class RiskChart extends StatelessWidget {
  final List<Nutrient> nutrients;
  const RiskChart({super.key, required this.nutrients});

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    final l10n = AppLocalizations.of(context)!;
    if (nutrients.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l10n.noNutrientData, style: text.bodyMedium),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.nutrients, style: text.titleMedium),
            const SizedBox(height: 12),
            ...nutrients.map(
              (n) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(n.label, style: text.bodyMedium),
                    Text(
                      '${n.value.toStringAsFixed(2)} g',
                      style: text.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
