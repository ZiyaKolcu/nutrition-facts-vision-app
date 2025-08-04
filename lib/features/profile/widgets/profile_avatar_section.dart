import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: colors.primaryContainer,
          backgroundImage: const NetworkImage(
            'https://i.pravatar.cc/150?img=10',
          ),
        ),
        const SizedBox(height: 8),
        Text('Jane Doe', style: text.headlineSmall),
        Text('jane.doe@example.com', style: text.bodyMedium),
      ],
    );
  }
}
