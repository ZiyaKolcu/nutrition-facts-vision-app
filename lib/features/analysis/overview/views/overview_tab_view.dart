import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/scan_detail_provider.dart';
import '../widgets/ai_summary_card.dart';
import '../widgets/ingredient_risk_card_list.dart';
import '../widgets/risk_chart.dart';

class OverviewTabView extends ConsumerWidget {
  final String scanId;
  const OverviewTabView({super.key, required this.scanId});

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
