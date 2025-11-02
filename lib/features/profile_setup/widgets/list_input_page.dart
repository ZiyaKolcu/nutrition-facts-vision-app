import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_setup_controller.dart';

enum ListInputType { allergies, healthConditions, dietaryPreferences }

class ListInputPage extends ConsumerWidget {
  final ListInputType type;
  final VoidCallback onNext;
  final bool isLast;

  const ListInputPage({
    super.key,
    required this.type,
    required this.onNext,
    this.isLast = false,
  });

  String get title {
    switch (type) {
      case ListInputType.allergies:
        return 'Any allergies?';
      case ListInputType.healthConditions:
        return 'Any health conditions?';
      case ListInputType.dietaryPreferences:
        return 'Dietary preferences?';
    }
  }

  String get subtitle {
    switch (type) {
      case ListInputType.allergies:
        return 'Add any food allergies you have';
      case ListInputType.healthConditions:
        return 'Add any health conditions we should know about';
      case ListInputType.dietaryPreferences:
        return 'Add your dietary preferences (e.g., Vegan, Vegetarian)';
    }
  }

  IconData get icon {
    switch (type) {
      case ListInputType.allergies:
        return Icons.warning_amber;
      case ListInputType.healthConditions:
        return Icons.medical_services;
      case ListInputType.dietaryPreferences:
        return Icons.restaurant_menu;
    }
  }

  List<String> _getItems(WidgetRef ref) {
    final data = ref.watch(profileSetupProvider);
    switch (type) {
      case ListInputType.allergies:
        return data.allergies;
      case ListInputType.healthConditions:
        return data.healthConditions;
      case ListInputType.dietaryPreferences:
        return data.dietaryPreferences;
    }
  }

  void _addItem(WidgetRef ref, String item) {
    final controller = ref.read(profileSetupProvider.notifier);
    switch (type) {
      case ListInputType.allergies:
        controller.addAllergy(item);
        break;
      case ListInputType.healthConditions:
        controller.addHealthCondition(item);
        break;
      case ListInputType.dietaryPreferences:
        controller.addDietaryPreference(item);
        break;
    }
  }

  void _removeItem(WidgetRef ref, String item) {
    final controller = ref.read(profileSetupProvider.notifier);
    switch (type) {
      case ListInputType.allergies:
        controller.removeAllergy(item);
        break;
      case ListInputType.healthConditions:
        controller.removeHealthCondition(item);
        break;
      case ListInputType.dietaryPreferences:
        controller.removeDietaryPreference(item);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = _getItems(ref);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () => _showAddDialog(context, ref),
            icon: Icon(icon),
            label: const Text('Add Item'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      'No items added yet',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(icon),
                          title: Text(items[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeItem(ref, items[index]),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(isLast ? 'Complete Setup' : 'Continue'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onNext,
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final itemType = type == ListInputType.allergies
        ? 'Allergy'
        : type == ListInputType.healthConditions
            ? 'Health Condition'
            : 'Dietary Preference';

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $itemType'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter $itemType',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      _addItem(ref, result);
    }
  }
}
