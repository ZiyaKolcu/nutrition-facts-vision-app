import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

const String _apiBaseOverride = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: '',
);

String get _baseUrl {
  if (_apiBaseOverride.isNotEmpty) {
    return _apiBaseOverride;
  }
  if (kIsWeb) return 'http://localhost:8000/api/v1';
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:8000/api/v1';
    default:
      return 'http://localhost:8000/api/v1';
  }
}

class ScanRepository {
  final http.Client httpClient;

  ScanRepository({http.Client? httpClient})
    : httpClient = httpClient ?? http.Client();

  Future<void> analyze({
    required List<ScanGroupItem> items,
    required String title,
    String? barcode,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? idToken = await user?.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('No idToken');
    }

    final uri = Uri.parse(
      '$_baseUrl/scans/analyze',
    ).replace(queryParameters: {'id_token': idToken});

    final String rawText = items
        .map((i) => i.text.trim())
        .where((t) => t.isNotEmpty)
        .join('\n\n');

    final payload = <String, dynamic>{
      'title': title,
      'raw_text': rawText,
      if (barcode != null && barcode.isNotEmpty) 'barcode': barcode,
    };

    try {
      final response = await httpClient
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Analyze request failed: $e');
      rethrow;
    }
  }
}

final scanRepositoryProvider = Provider<ScanRepository>(
  (ref) => ScanRepository(),
);

class ScanGroupItem {
  final String imagePath;
  final String text;

  const ScanGroupItem({required this.imagePath, required this.text});
}
