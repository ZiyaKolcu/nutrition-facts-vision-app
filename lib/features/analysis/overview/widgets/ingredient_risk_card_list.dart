import 'package:flutter/material.dart';
import '../models/scan_detail_model.dart';
import 'ingredient_risk_card.dart';

class IngredientRiskCardList extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientRiskCardList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const Text('No ingredient data available');
    }
    return Column(
      children: ingredients
          .map(
            (ingredient) => IngredientRiskCard(
              name: ingredient.name,
              level: ingredient.riskLevel,
            ),
          )
          .toList(),
    );
  }
}
