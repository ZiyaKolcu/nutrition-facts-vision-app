class ScanDetail {
  final String id;
  final String? productName;
  final String? summaryExplanation;
  final List<Ingredient> ingredients;
  final List<Nutrient> nutrients;

  ScanDetail({
    required this.id,
    this.productName,
    this.summaryExplanation,
    required this.ingredients,
    required this.nutrients,
  });

  factory ScanDetail.fromJson(Map<String, dynamic> json) {
    return ScanDetail(
      id: json['id'] as String,
      productName: json['product_name'] as String?,
      summaryExplanation: json['summary_explanation'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>? ?? [])
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      nutrients: (json['nutrients'] as List<dynamic>? ?? [])
          .map((e) => Nutrient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Ingredient {
  final String name;
  final String riskLevel;

  Ingredient({required this.name, required this.riskLevel});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String? ?? '',
      riskLevel: json['risk_level'] as String? ?? '',
    );
  }
}

class Nutrient {
  final String label;
  final double value;

  Nutrient({required this.label, required this.value});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      label: json['label'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
