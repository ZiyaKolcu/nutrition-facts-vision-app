import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/theme_extensions.dart';
import '../models/health_profile.dart';

class ProfileInfoSection extends StatelessWidget {
  final HealthProfile profile;
  final void Function(DateTime?) onDateOfBirthChanged;
  final void Function(String?) onGenderChanged;
  final void Function(int?) onHeightChanged;
  final void Function(int?) onWeightChanged;

  const ProfileInfoSection({
    super.key,
    required this.profile,
    required this.onDateOfBirthChanged,
    required this.onGenderChanged,
    required this.onHeightChanged,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Birth Date Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Birth Date', style: text.titleSmall),

                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              profile.dateOfBirth != null
                                  ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(profile.dateOfBirth!)
                                  : 'Select Date',
                              style: text.bodyMedium?.copyWith(
                                color: profile.dateOfBirth != null
                                    ? colors.onSurface
                                    : colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Gender Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender', style: text.titleSmall),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: profile.gender?.isEmpty == true
                            ? null
                            : profile.gender,
                        hint: Text(
                          'Select Gender',
                          style: text.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: onGenderChanged,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Height and Weight Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Height Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Height (cm)', style: text.titleSmall),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter height',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    controller: TextEditingController(
                      text: profile.heightCm != null && profile.heightCm! > 0
                          ? profile.heightCm.toString()
                          : '',
                    ),
                    onSubmitted: (value) {
                      final height = int.tryParse(value);
                      onHeightChanged(height);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Weight Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weight (kg)', style: text.titleSmall),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter weight',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    controller: TextEditingController(
                      text: profile.weightKg != null && profile.weightKg! > 0
                          ? profile.weightKg.toString()
                          : '',
                    ),
                    onSubmitted: (value) {
                      final weight = int.tryParse(value);
                      onWeightChanged(weight);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime initialDate;

    // Use profile date if valid, otherwise use a reasonable default (30 years ago)
    if (profile.dateOfBirth != null &&
        profile.dateOfBirth!.isBefore(now) &&
        profile.dateOfBirth!.isAfter(DateTime(1900))) {
      initialDate = profile.dateOfBirth!;
    } else {
      initialDate = DateTime(now.year - 30, now.month, now.day);
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );

    if (picked != null && picked != profile.dateOfBirth) {
      onDateOfBirthChanged(picked);
    }
  }
}
