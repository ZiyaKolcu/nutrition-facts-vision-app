import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../l10n/app_localizations.dart';
import '../controllers/health_profile_notifier.dart';
import '../widgets/profile_avatar_section.dart';
import '../widgets/profile_settings_list.dart';
import '../widgets/profile_chip_section.dart';
import '../widgets/profile_info_section.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                await user.reload();
                await ref.read(healthProfileProvider.notifier).fetchProfile();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.profileRefreshed)),
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
                    const SizedBox(height: 16),
                    ProfileInfoSection(
                      profile: profile,
                      onDateOfBirthChanged: (date) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(dateOfBirth: date),
                      onGenderChanged: (gender) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(gender: gender),
                      onHeightChanged: (height) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(heightCm: height),
                      onWeightChanged: (weight) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(weightKg: weight),
                    ),
                    const SizedBox(height: 16),
                    ProfileChipSection(
                      title: l10n.allergies,
                      items: profile.allergies,
                      onChanged: (list) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(allergies: list),
                    ),
                    ProfileChipSection(
                      title: l10n.healthConditions,
                      items: profile.healthConditions,
                      onChanged: (list) => ref
                          .read(healthProfileProvider.notifier)
                          .updateProfileField(healthConditions: list),
                    ),
                    ProfileChipSection(
                      title: l10n.dietaryPreferences,
                      items: profile.dietaryPreferences,
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
