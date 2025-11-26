import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../models/scan_detail_model.dart';
import 'ingredient_risk_chip.dart';

class IngredientRiskChipList extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientRiskChipList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ingredients.isEmpty) {
      return Text(l10n.noIngredientData);
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ingredients
          .map(
            (ingredient) => IngredientRiskChip(
              name: ingredient.name,
              level: ingredient.riskLevel,
            ),
          )
          .toList(),
    );
  }
}
