import 'package:flutter/material.dart';
import '../../analysis/analysis_screen.dart';

class ScanItemCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  final Future<void> Function()? onDelete;

  const ScanItemCard({
    super.key,
    required this.title,
    this.date,
    this.onDelete,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final displayDate = date ?? DateTime.now();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(
            Icons.restaurant,
            size: 20,
            color: colors.onPrimaryContainer,
          ),
        ),
        title: Text(
          title,
          style: text.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          _formatDate(displayDate),
          style: text.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: colors.error,
              tooltip: 'Delete',
              onPressed: onDelete == null
                  ? null
                  : () {
                      onDelete!();
                    },
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AnalysisScreen()));
        },
      ),
    );
  }
}
