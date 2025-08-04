import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: text.titleMedium),
        const SizedBox(height: 8),
        const _SettingsTile(Icons.person_outline, 'Edit Profile'),
        const _SettingsTile(Icons.notifications_none, 'Notifications'),
        const _SettingsTile(Icons.lock_outline, 'Privacy & Security'),
        const _SettingsTile(Icons.help_outline, 'Help Center'),
        const _SettingsTile(Icons.info_outline, 'About'),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            onPressed: () {
              /* Signout */
            },
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SettingsTile(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        /* todo */
      },
    );
  }
}
