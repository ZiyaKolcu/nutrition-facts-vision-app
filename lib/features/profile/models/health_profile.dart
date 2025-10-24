class HealthProfile {
  final String userId;
  final List<String> allergies;
  final List<String> healthConditions;
  final List<String> dietaryPreferences;
  final int? age;
  final String? gender;
  final int? heightCm;
  final int? weightKg;

  HealthProfile({
    required this.userId,
    required this.allergies,
    required this.healthConditions,
    required this.dietaryPreferences,
    this.age,
    this.gender,
    this.heightCm,
    this.weightKg,
  });

  factory HealthProfile.fromJson(Map<String, dynamic> json) => HealthProfile(
    userId: json['user_id'] ?? '',
    allergies: List<String>.from(json['allergies'] ?? []),
    healthConditions: List<String>.from(json['health_conditions'] ?? []),
    dietaryPreferences: List<String>.from(json['dietary_preferences'] ?? []),
    age: json['age'],
    gender: json['gender'],
    heightCm: json['height_cm'],
    weightKg: json['weight_kg'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'allergies': allergies,
    'health_conditions': healthConditions,
    'dietary_preferences': dietaryPreferences,
    'age': age ?? 0,
    'gender': gender ?? '',
    'height_cm': heightCm ?? 0,
    'weight_kg': weightKg ?? 0,
  };

  HealthProfile copyWith({
    List<String>? allergies,
    List<String>? healthConditions,
    List<String>? dietaryPreferences,
    int? age,
    String? gender,
    int? heightCm,
    int? weightKg,
  }) {
    return HealthProfile(
      userId: userId,
      allergies: allergies ?? this.allergies,
      healthConditions: healthConditions ?? this.healthConditions,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
    );
  }
}
