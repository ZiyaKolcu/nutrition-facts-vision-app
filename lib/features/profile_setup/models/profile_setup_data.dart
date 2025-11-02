class ProfileSetupData {
  String? gender;
  DateTime? dateOfBirth;
  int? heightCm;
  int? weightKg;
  List<String> allergies;
  List<String> healthConditions;
  List<String> dietaryPreferences;

  ProfileSetupData({
    this.gender,
    this.dateOfBirth,
    this.heightCm,
    this.weightKg,
    List<String>? allergies,
    List<String>? healthConditions,
    List<String>? dietaryPreferences,
  })  : allergies = allergies ?? [],
        healthConditions = healthConditions ?? [],
        dietaryPreferences = dietaryPreferences ?? [];

  bool get isGenderValid => gender != null;
  bool get isDateOfBirthValid => dateOfBirth != null;
  bool get isHeightWeightValid => heightCm != null && weightKg != null;
}
