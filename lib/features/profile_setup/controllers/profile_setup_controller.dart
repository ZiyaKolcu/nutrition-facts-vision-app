import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../profile/controllers/health_profile_notifier.dart';
import '../models/profile_setup_data.dart';

class ProfileSetupController extends StateNotifier<ProfileSetupData> {
  ProfileSetupController() : super(ProfileSetupData());

  void setGender(String? gender) {
    state.gender = gender;
    state = ProfileSetupData(
      gender: gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void setDateOfBirth(DateTime? date) {
    state.dateOfBirth = date;
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: date,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void setHeight(int? height) {
    state.heightCm = height;
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: height,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void setWeight(int? weight) {
    state.weightKg = weight;
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: weight,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void addAllergy(String allergy) {
    state.allergies.add(allergy);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: List.from(state.allergies),
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void removeAllergy(String allergy) {
    state.allergies.remove(allergy);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: List.from(state.allergies),
      healthConditions: state.healthConditions,
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void addHealthCondition(String condition) {
    state.healthConditions.add(condition);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: List.from(state.healthConditions),
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void removeHealthCondition(String condition) {
    state.healthConditions.remove(condition);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: List.from(state.healthConditions),
      dietaryPreferences: state.dietaryPreferences,
    );
  }

  void addDietaryPreference(String preference) {
    state.dietaryPreferences.add(preference);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: List.from(state.dietaryPreferences),
    );
  }

  void removeDietaryPreference(String preference) {
    state.dietaryPreferences.remove(preference);
    state = ProfileSetupData(
      gender: state.gender,
      dateOfBirth: state.dateOfBirth,
      heightCm: state.heightCm,
      weightKg: state.weightKg,
      allergies: state.allergies,
      healthConditions: state.healthConditions,
      dietaryPreferences: List.from(state.dietaryPreferences),
    );
  }

  Future<void> completeSetup(WidgetRef ref) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) throw Exception('No authentication token');

    await ref.read(healthProfileProvider.notifier).fetchProfile(idToken);

    await ref.read(healthProfileProvider.notifier).updateProfileField(
          gender: state.gender,
          dateOfBirth: state.dateOfBirth,
          heightCm: state.heightCm,
          weightKg: state.weightKg,
          allergies: state.allergies,
          healthConditions: state.healthConditions,
          dietaryPreferences: state.dietaryPreferences,
        );
  }
}

final profileSetupProvider =
    StateNotifierProvider<ProfileSetupController, ProfileSetupData>(
  (ref) => ProfileSetupController(),
);
