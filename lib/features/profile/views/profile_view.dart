import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/health_profile_notifier.dart';
import '../widgets/profile_avatar_section.dart';
import '../widgets/profile_settings_list.dart';
import '../widgets/profile_chip_section.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Future.microtask(
        () => ref.read(healthProfileProvider.notifier).fetchProfile(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profileAsync = ref.watch(healthProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                await user.reload();
                await ref.read(healthProfileProvider.notifier).fetchProfile();
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
          : profileAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (profile) {
                if (profile == null) {
                  return const Center(child: Text('No profile data'));
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const ProfileAvatarSection(),
                    ProfileChipSection(
                      title: 'Allergies',
                      items: profile.allergies,
                      icon: Icons.warning,
                      onChanged: (list) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(allergies: list),
                    ),
                    ProfileChipSection(
                      title: 'Health Conditions',
                      items: profile.chronicConditions,
                      icon: Icons.medical_services,
                      onChanged: (list) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(chronicConditions: list),
                    ),
                    ProfileChipSection(
                      title: 'Dietary Preferences',
                      items: profile.dietaryPreferences,
                      icon: Icons.restaurant,
                      onChanged: (list) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(dietaryPreferences: list),
                    ),
                    const SettingsList(),
                  ],
                );
              },
            ),
    );
  }
}
