import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'scan_item_card.dart';

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

class ScanSummary {
  final String scanId;
  final String productName;
  final DateTime? createdAt;

  const ScanSummary({
    required this.scanId,
    required this.productName,
    this.createdAt,
  });

  factory ScanSummary.fromJson(Map<String, dynamic> json) {
    final String? createdAtRaw =
        (json['created_at'] ?? json['createdAt']) as String?;
    final dynamic idRaw = json['scan_id'] ?? json['id'];
    final dynamic nameRaw = json['product_name'] ?? json['productName'];
    final String name = nameRaw?.toString().trim().isNotEmpty == true
        ? nameRaw.toString()
        : 'Untitled';
    return ScanSummary(
      scanId: idRaw?.toString() ?? '',
      productName: name,
      createdAt: createdAtRaw != null && createdAtRaw.isNotEmpty
          ? DateTime.tryParse(createdAtRaw)
          : null,
    );
  }
}

final authUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final scansProvider = FutureProvider<List<ScanSummary>>((ref) async {
  final auth = ref.watch(authUserProvider);
  final User? user = auth.asData?.value;
  final String? idToken = await user?.getIdToken();
  if (idToken == null || idToken.isEmpty) {
    return <ScanSummary>[];
  }

  final uri = Uri.parse(
    '$_baseUrl/scans/me',
  ).replace(queryParameters: {'id_token': idToken});

  final response = await http.get(uri).timeout(const Duration(seconds: 10));
  if (response.statusCode == 200) {
    final dynamic decoded = json.decode(response.body);
    if (decoded is List) {
      return decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => ScanSummary.fromJson(e))
          .toList();
    }
    return <ScanSummary>[];
  }
  if (response.statusCode == 404) {
    return <ScanSummary>[];
  }
  throw Exception('Failed to fetch scans (${response.statusCode})');
});

class ScanHistoryList extends ConsumerWidget {
  const ScanHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scansAsync = ref.watch(scansProvider);
    return scansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Failed to load scans. ${err.toString()}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      data: (scans) {
        if (scans.isEmpty) {
          return const Center(child: Text('No scans yet'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = scans[index];
            return ScanItemCard(
              title: item.productName,
              date: item.createdAt,
              onDelete: () async {
                if (item.scanId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Scan id missing, cannot delete'),
                    ),
                  );
                  return;
                }
                await _deleteScan(context, ref, item.scanId);
              },
            );
          },
        );
      },
    );
  }
}

Future<void> _deleteScan(
  BuildContext context,
  WidgetRef ref,
  String scanId,
) async {
  if (scanId.isEmpty) return;
  try {
    ScaffoldMessenger.of(
      context,
    );
    final String? idToken = await FirebaseAuth.instance.currentUser
        ?.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('No idToken');
    }
    final uri = Uri.parse(
      '$_baseUrl/scans/$scanId',
    ).replace(queryParameters: {'id_token': idToken});
    final res = await http
        .delete(uri, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 15));
    if (res.statusCode == 200 || res.statusCode == 204) {
      ref.invalidate(scansProvider);
      ScaffoldMessenger.of(
        context,
      );
      return;
    }
    throw Exception('Failed (${res.statusCode})');
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
  }
}
