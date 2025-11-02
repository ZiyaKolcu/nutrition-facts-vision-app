import 'package:flutter/material.dart';
import '../models/scan_detail_model.dart';
import 'ingredient_risk_chip.dart';

class IngredientRiskChipList extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientRiskChipList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const Text('No ingredient data available');
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
