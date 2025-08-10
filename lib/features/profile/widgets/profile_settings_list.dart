import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/theme_extensions.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  Future<void> _signOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        // Navigate to root and let AuthGate rebuild to SignInScreen
        Navigator.of(context).popUntil((route) => route.isFirst);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Sign out failed: $e')));
        }
      }
    }
  }

  Future<void> _sendEmailVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent!')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send verification: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: text.titleMedium),
        const SizedBox(height: 8),
        const _SettingsTile(Icons.person_outline, 'Edit Profile'),
        const _SettingsTile(Icons.notifications_none, 'Notifications'),
        const _SettingsTile(Icons.lock_outline, 'Privacy & Security'),

        if (user != null && !user.emailVerified)
          _SettingsTile(
            Icons.mark_email_unread,
            'Verify Email',
            onTap: () => _sendEmailVerification(context),
          ),

        const _SettingsTile(Icons.help_outline, 'Help Center'),
        const _SettingsTile(Icons.info_outline, 'About'),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account Info', style: text.titleSmall),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: context.colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Created: ${_formatDate(user?.metadata.creationTime)}',
                    style: text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.login,
                    size: 16,
                    color: context.colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Last Sign In: ${_formatDate(user?.metadata.lastSignInTime)}',
                    style: text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colors.error,
              side: BorderSide(color: context.colors.error),
            ),
            onPressed: () => _signOut(context),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _SettingsTile(this.icon, this.title, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap:
          onTap ??
          () {
            /* todo */
          },
    );
  }
}
