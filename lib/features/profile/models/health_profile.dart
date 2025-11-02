class HealthProfile {
  final String userId;
  final List<String> allergies;
  final List<String> healthConditions;
  final List<String> dietaryPreferences;
  final String? gender;
  final DateTime? dateOfBirth;
  final int? heightCm;
  final int? weightKg;

  HealthProfile({
    required this.userId,
    required this.allergies,
    required this.healthConditions,
    required this.dietaryPreferences,
    this.gender,
    this.dateOfBirth,
    this.heightCm,
    this.weightKg,
  });

  factory HealthProfile.fromJson(Map<String, dynamic> json) => HealthProfile(
    userId: json['user_id'] ?? '',
    allergies: List<String>.from(json['allergies'] ?? []),
    healthConditions: List<String>.from(json['health_conditions'] ?? []),
    dietaryPreferences: List<String>.from(json['dietary_preferences'] ?? []),
    gender: json['gender'],
    dateOfBirth: json['date_of_birth'] != null
        ? DateTime.tryParse(json['date_of_birth'])
        : null,
    heightCm: json['height_cm'],
    weightKg: json['weight_kg'],
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'user_id': userId,
      'allergies': allergies,
      'health_conditions': healthConditions,
      'dietary_preferences': dietaryPreferences,
    };

    // Only add optional fields if they have values
    if (gender != null && gender!.isNotEmpty) {
      map['gender'] = gender;
    }
    if (dateOfBirth != null) {
      // Format as YYYY-MM-DD for backend date field
      map['date_of_birth'] =
          '${dateOfBirth!.year.toString().padLeft(4, '0')}-'
          '${dateOfBirth!.month.toString().padLeft(2, '0')}-'
          '${dateOfBirth!.day.toString().padLeft(2, '0')}';
    }
    if (heightCm != null && heightCm! > 0) {
      map['height_cm'] = heightCm;
    }
    if (weightKg != null && weightKg! > 0) {
      map['weight_kg'] = weightKg;
    }

    return map;
  }

  HealthProfile copyWith({
    List<String>? allergies,
    List<String>? healthConditions,
    List<String>? dietaryPreferences,
    String? gender,
    DateTime? dateOfBirth,
    int? heightCm,
    int? weightKg,
  }) {
    return HealthProfile(
      userId: userId,
      allergies: allergies ?? this.allergies,
      healthConditions: healthConditions ?? this.healthConditions,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
    );
  }
}
