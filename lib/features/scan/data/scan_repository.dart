import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ScanRepository {
  final String baseUrl;
  final http.Client httpClient;

  ScanRepository({
    this.baseUrl = 'http://10.0.2.2:8000',
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  /// Analyzes one or multiple photos/texts
  /// Works for both single and multiple items
  Future<void> analyze({
    required List<ScanGroupItem> items,
    String? title,
  }) async {
    // Placeholder for future FastAPI integration.
    // Keep signature and basic request structure ready.
    // final Uri url = Uri.parse('$baseUrl/analyze');
    // final Map<String, dynamic> payload = {
    //   if (title != null && title.isNotEmpty) 'title': title,
    //   'items': items
    //       .map((item) => {
    //             'image_path': item.imagePath,
    //             'ingredients_text': item.text,
    //           })
    //       .toList(),
    // };

    // Intentionally not awaiting a real backend in this phase; return early if baseUrl not reachable.
    try {
      // Commented out actual request to avoid errors if backend is not running.
      // final http.Response response = await httpClient.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(payload),
      // );
      //
      // if (response.statusCode < 200 || response.statusCode >= 300) {
      //   throw Exception('Backend error: ${response.statusCode}');
      // }
    } catch (_) {
      // Swallow errors for now since backend may not be running during UI development.
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
