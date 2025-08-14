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
              radius: 64,
              backgroundColor: colors.primaryContainer,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Icon(
                      Icons.person,
                      size: 64,
                      color: colors.onPrimaryContainer,
                    )
                  : null,
            ),
            const SizedBox(height: 12),
            Text(displayName, style: text.headlineSmall),
          ],
        );
      },
    );
  }
}
