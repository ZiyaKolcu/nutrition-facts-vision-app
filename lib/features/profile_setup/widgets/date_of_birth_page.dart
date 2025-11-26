import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/profile_setup_controller.dart';

class DateOfBirthPage extends ConsumerWidget {
  final VoidCallback onNext;

  const DateOfBirthPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final data = ref.watch(profileSetupProvider);
    final controller = ref.read(profileSetupProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            l10n.whensBirthday,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: data.dateOfBirth ?? DateTime(now.year - 30),
                firstDate: DateTime(1900),
                lastDate: now,
              );
              if (picked != null) {
                controller.setDateOfBirth(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 16),
                  Text(
                    data.dateOfBirth != null
                        ? '${data.dateOfBirth!.day}/${data.dateOfBirth!.month}/${data.dateOfBirth!.year}'
                        : l10n.selectBirthDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: data.isDateOfBirthValid ? onNext : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(l10n.continueButton),
          ),
        ],
      ),
    );
  }
}
