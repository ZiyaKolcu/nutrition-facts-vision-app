import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';
import '../analysis/widgets/ai_summary_card.dart';
import '../analysis/widgets/ingredient_risk_card_list.dart';
import '../analysis/widgets/risk_chart.dart';
import '../analysis/widgets/chat_with_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'scan_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

final scanDetailProvider = FutureProvider.family<ScanDetail, String>((
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
});

class AnalysisScreen extends StatelessWidget {
  final String scanId;
  final String title;
  const AnalysisScreen({super.key, required this.scanId, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            labelColor: context.colors.onPrimary,
            unselectedLabelColor: context.colors.onPrimary.withValues(
              alpha: .7,
            ),
            indicatorColor: context.colors.onPrimary,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Ask AI'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _OverviewTab(scanId: scanId),
            const _AskAITab(),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------------------
   TAB 1 – Overview
-------------------------------------------*/
class _OverviewTab extends ConsumerWidget {
  final String scanId;
  const _OverviewTab({required this.scanId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanDetailAsync = ref.watch(scanDetailProvider(scanId));
    return scanDetailAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (scan) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AiSummaryCard(
              summary: scan.summaryExplanation ?? 'No summary available.',
            ),
            const SizedBox(height: 16),
            IngredientRiskCardList(ingredients: scan.ingredients),
            const SizedBox(height: 16),
            RiskChart(nutrients: scan.nutrients),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------------------
   TAB 2 – Ask AI
-------------------------------------------*/
class _AskAITab extends StatelessWidget {
  const _AskAITab();

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(16), child: ChatWithAI());
  }
}
