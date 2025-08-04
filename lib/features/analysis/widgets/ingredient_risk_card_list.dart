import 'package:flutter/material.dart';
import 'ingredient_risk_card.dart';

class IngredientRiskCardList extends StatelessWidget {
  const IngredientRiskCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        IngredientRiskCard(name: 'Carrageenan', level: 'Medium'),
        IngredientRiskCard(name: 'Added Sugar', level: 'Low'),
        IngredientRiskCard(name: 'Sodium', level: 'Low'),
      ],
    );
  }
}
