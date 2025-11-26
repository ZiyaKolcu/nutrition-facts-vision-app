import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/api_base.dart';
import '../../../core/localization/locale_provider.dart';

String get _baseUrl => getApiBase();

class ScanRepository {
  final http.Client httpClient;
  final Ref ref;

  ScanRepository({http.Client? httpClient, required this.ref})
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

    final locale = ref.read(localeProvider);
    final language = locale.languageCode;

    final payload = <String, dynamic>{
      'title': title,
      'raw_text': rawText,
      'language': language,
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
  (ref) => ScanRepository(ref: ref),
);

class ScanGroupItem {
  final String imagePath;
  final String text;

  const ScanGroupItem({required this.imagePath, required this.text});
}
