import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/profile_avatar_section.dart';
import 'widgets/profile_settings_list.dart';
import 'widgets/profile_chip_section.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                await user.reload();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile refreshed')),
                  );
                }
              },
            ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('No user logged in'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const ProfileAvatarSection(),
                const SizedBox(height: 24),
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
