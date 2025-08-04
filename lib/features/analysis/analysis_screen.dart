import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';
import '../analysis/widgets/product_info_header.dart';
import '../analysis/widgets/ai_summary_card.dart';
import '../analysis/widgets/ingredient_risk_card_list.dart';
import '../analysis/widgets/risk_chart.dart';
import '../analysis/widgets/chat_with_ai.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analysis Result'),
          bottom: TabBar(
            labelColor: context.colors.onPrimary,
            unselectedLabelColor: context.colors.onPrimary.withValues(alpha: .7),
            indicatorColor: context.colors.onPrimary,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Details'),
              Tab(text: 'Ask AI'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _DetailsTab(),
            _AskAITab(),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------------------
   TAB 1 – Overview
-------------------------------------------*/
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          ProductInfoHeader(),
          SizedBox(height: 16),
          AiSummaryCard(),
        ],
      ),
    );
  }
}

/* ------------------------------------------
   TAB 2 – Details
-------------------------------------------*/
class _DetailsTab extends StatelessWidget {
  const _DetailsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          RiskChart(),
          SizedBox(height: 16),
          IngredientRiskCardList(),
        ],
      ),
    );
  }
}

/* ------------------------------------------
   TAB 3 – Ask AI
-------------------------------------------*/
class _AskAITab extends StatelessWidget {
  const _AskAITab();

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(16), child: ChatWithAI());
  }
}
