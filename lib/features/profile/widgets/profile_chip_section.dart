import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_extensions.dart';

final allergiesProvider = StateProvider<List<String>>(
  (ref) => ['Peanuts', 'Shellfish', 'Latex'],
);

final conditionsProvider = StateProvider<List<String>>(
  (ref) => ['Lactose Intolerant', 'Hypertension'],
);

class ProfileChipSection extends ConsumerWidget {
  final String title;
  final StateProvider<List<String>> provider;
  final IconData icon;

  const ProfileChipSection({
    super.key,
    required this.title,
    required this.provider,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(provider);
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
              onPressed: () => _addItem(context, ref),
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
                  onDeleted: () => ref
                      .read(provider.notifier)
                      .update((state) => state.where((s) => s != e).toList()),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _addItem(BuildContext context, WidgetRef ref) async {
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
      ref.read(provider.notifier).update((state) => [...state, res]);
    }
  }
}
