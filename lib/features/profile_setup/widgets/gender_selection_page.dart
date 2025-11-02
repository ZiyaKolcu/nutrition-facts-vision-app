import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_setup_controller.dart';

class GenderSelectionPage extends ConsumerWidget {
  final VoidCallback onNext;

  const GenderSelectionPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(profileSetupProvider);
    final controller = ref.read(profileSetupProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'What\'s your gender?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          _GenderOption(
            gender: 'Male',
            isSelected: data.gender == 'Male',
            onTap: () => controller.setGender('Male'),
          ),
          const SizedBox(height: 16),
          _GenderOption(
            gender: 'Female',
            isSelected: data.gender == 'Female',
            onTap: () => controller.setGender('Female'),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: data.isGenderValid ? onNext : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            Icon(
              gender == 'Male' ? Icons.male : gender == 'Female' ? Icons.female : Icons.person,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            const SizedBox(width: 16),
            Text(
              gender,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).primaryColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
