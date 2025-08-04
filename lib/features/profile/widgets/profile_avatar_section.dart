import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/theme_extensions.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        String displayName = user?.displayName ?? 'User';
        if (displayName.isEmpty) {
          displayName = user?.email?.split('@').first ?? 'User';
        }

        return Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: colors.primaryContainer,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Text(
                      displayName.isNotEmpty
                          ? displayName[0].toUpperCase()
                          : 'U',
                      style: text.headlineLarge?.copyWith(
                        color: colors.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            Text(displayName, style: text.headlineSmall),
            Text(
              user?.email ?? 'No email',
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            if (user != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: user.emailVerified
                      ? colors.secondary
                      : colors.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user.emailVerified ? 'Email verified' : 'Email not verified',
                  style: text.labelSmall?.copyWith(
                    color: user.emailVerified
                        ? colors.onPrimary
                        : colors.onErrorContainer,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
