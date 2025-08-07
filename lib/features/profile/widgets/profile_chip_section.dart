import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class ProfileChipSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;
  final void Function(List<String>) onChanged;

  const ProfileChipSection({
    super.key,
    required this.title,
    required this.items,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: colors.primary),
            const SizedBox(width: 6),
            Text(title, style: text.titleSmall),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addItem(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map(
                (e) => Chip(
                  label: Text(e, style: text.labelSmall),
                  backgroundColor: colors.primaryContainer,
                  side: BorderSide.none,
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () {
                    final updated = List<String>.from(items)..remove(e);
                    onChanged(updated);
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _addItem(BuildContext context) async {
    final textCtrl = TextEditingController();
    final res = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add $title'),
        content: TextField(controller: textCtrl, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, textCtrl.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (res != null && res.isNotEmpty) {
      final updated = List<String>.from(items)..add(res);
      onChanged(updated);
    }
  }
}
