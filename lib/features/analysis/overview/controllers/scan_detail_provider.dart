import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/api_base.dart';
import '../models/scan_detail_model.dart';

final String _baseUrl = getApiBase();

final scanDetailProvider = FutureProvider.family<ScanDetail, String>(((
  ref,
  scanId,
) async {
  final user = FirebaseAuth.instance.currentUser;
  final idToken = await user?.getIdToken();
  if (idToken == null) throw Exception('No idToken');
  final uri = Uri.parse('$_baseUrl/scans/$scanId?id_token=$idToken');
  final res = await http.get(uri).timeout(const Duration(seconds: 15));
  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    return ScanDetail.fromJson(data);
  }
  throw Exception('Failed to fetch scan detail');
}));
