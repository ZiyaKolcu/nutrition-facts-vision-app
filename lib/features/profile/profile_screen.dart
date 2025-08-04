import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/profile_avatar_section.dart';
import 'widgets/profile_settings_list.dart';
import 'widgets/profile_chip_section.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProfileAvatarSection(),
          ProfileChipSection(
            title: 'Allergies',
            provider: allergiesProvider,
            icon: Icons.warning,
          ),

          ProfileChipSection(
            title: 'Health Conditions',
            provider: conditionsProvider,
            icon: Icons.medical_services,
          ),
          const SettingsList(),
        ],
      ),
    );
  }
}
