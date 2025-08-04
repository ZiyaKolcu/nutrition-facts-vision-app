import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class ChatWithAI extends StatelessWidget {
  const ChatWithAI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _ChatBubble(
                text: 'Can I drink this if I am lactose intolerant?',
                isUser: true,
              ),
              _ChatBubble(text: 'Yes, it is lactose-free.', isUser: false),
            ],
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Ask anything...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyle = context.textStyles.bodyMedium;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? colors.primary : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: textStyle?.copyWith(color: isUser ? Colors.white : null),
        ),
      ),
    );
  }
}
