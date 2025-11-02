import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utils/api_base.dart';
import '../models/health_profile.dart';

String get _baseUrl => getApiBase();

class HealthProfileNotifier extends StateNotifier<AsyncValue<HealthProfile?>> {
  HealthProfileNotifier() : super(const AsyncValue.loading());

  String? _idToken;
  String? _userId;

  Future<void> fetchProfile([String? idToken]) async {
    state = const AsyncValue.loading();
    try {
      _idToken =
          idToken ?? await FirebaseAuth.instance.currentUser?.getIdToken();
      if (_idToken == null) throw Exception('No idToken');
      _userId = await _fetchUserId(_idToken!);
      if (_userId == null) throw Exception('No userId');
      final profile = await _fetchProfile(_idToken!);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfileField({
    List<String>? allergies,
    List<String>? healthConditions,
    List<String>? dietaryPreferences,
    String? gender,
    DateTime? dateOfBirth,
    int? heightCm,
    int? weightKg,
  }) async {
    final current = state.value;
    if (current == null || _idToken == null || _userId == null) return;
    final updated = current.copyWith(
      allergies: allergies,
      healthConditions: healthConditions,
      dietaryPreferences: dietaryPreferences,
      gender: gender,
      dateOfBirth: dateOfBirth,
      heightCm: heightCm,
      weightKg: weightKg,
    );
    state = const AsyncValue.loading();
    try {
      await _putProfile(_idToken!, updated);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String?> _fetchUserId(String idToken) async {
    final res = await http
        .get(Uri.parse('$_baseUrl/auth/me?id_token=$idToken'))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['id'] as String?;
    }
    throw Exception('Failed to fetch user id');
  }

  Future<HealthProfile?> _fetchProfile(String idToken) async {
    final res = await http
        .get(Uri.parse('$_baseUrl/health-profile/me?id_token=$idToken'))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return HealthProfile.fromJson(data);
    } else if (res.statusCode == 404) {
      final created = await _postProfile(idToken);
      return created;
    }
    throw Exception('Failed to fetch profile');
  }

  Future<HealthProfile?> _postProfile(String idToken) async {
    if (_userId == null) throw Exception('No userId');
    final body = json.encode({
      'user_id': _userId,
      'allergies': [],
      'health_conditions': [],
      'dietary_preferences': [],
    });
    final res = await http
        .post(
          Uri.parse('$_baseUrl/health-profile/me?id_token=$idToken'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        )
        .timeout(const Duration(seconds: 10));
    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = json.decode(res.body);
      return HealthProfile.fromJson(data);
    }
    throw Exception('Failed to create profile');
  }

  Future<void> _putProfile(String idToken, HealthProfile profile) async {
    final jsonData = profile.toJson();
    final body = json.encode(jsonData);

    // Debug: Print what we're sending
    print('Sending to backend: $jsonData');

    final res = await http
        .put(
          Uri.parse('$_baseUrl/health-profile/me?id_token=$idToken'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        )
        .timeout(const Duration(seconds: 10));

    print('Response status: ${res.statusCode}');
    print('Response body: ${res.body}');

    if (res.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}

final healthProfileProvider =
    StateNotifierProvider<HealthProfileNotifier, AsyncValue<HealthProfile?>>(
      (ref) => HealthProfileNotifier(),
    );
