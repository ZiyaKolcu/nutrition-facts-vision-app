import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';
import 'chat/views/chat_with_ai_view.dart';
import 'overview/views/overview_tab_view.dart';

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
            _AskAITab(scanId: scanId),
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
  final String scanId;
  const _OverviewTab({required this.scanId});

  @override
  Widget build(BuildContext context) {
    return OverviewTabView(scanId: scanId);
  }
}

/* ------------------------------------------
   TAB 2 – Ask AI
-------------------------------------------*/
class _AskAITab extends StatelessWidget {
  final String scanId;
  const _AskAITab({required this.scanId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ChatWithAI(scanId: scanId),
    );
  }
}
