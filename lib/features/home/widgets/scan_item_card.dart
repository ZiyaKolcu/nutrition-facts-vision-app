import 'package:flutter/material.dart';
import '../../analysis/analysis_screen.dart';

class ScanItemCard extends StatelessWidget {
  final String title;
  const ScanItemCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: const Icon(Icons.image, size: 20),
        ),
        title: Text(title, style: text.titleMedium),
        subtitle: Text('Tap to view analysis', style: text.bodySmall),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AnalysisScreen()));
        },
      ),
    );
  }
}
