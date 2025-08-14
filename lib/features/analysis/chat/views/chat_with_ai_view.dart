import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/chat_notifier.dart';
import '../widgets/chat_bubble.dart';
import '../../../../core/theme/theme_extensions.dart';

class ChatWithAI extends ConsumerStatefulWidget {
  final String scanId;
  const ChatWithAI({super.key, required this.scanId});

  @override
  ConsumerState<ChatWithAI> createState() => _ChatWithAIState();
}

class _ChatWithAIState extends ConsumerState<ChatWithAI> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    _controller.clear();
    await ref
        .read(chatMessagesProvider(widget.scanId).notifier)
        .sendMessage(text);
    if (mounted) {
      setState(() => _sending = false);
      await Future.delayed(const Duration(milliseconds: 100));
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncMessages = ref.watch(chatMessagesProvider(widget.scanId));
    final colors = context.colors;

    return Column(
      children: [
        Expanded(
          child: asyncMessages.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
            data: (messages) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isTyping = msg.id.startsWith('typing-');
                  return ChatBubble(
                    text: isTyping ? '...' : msg.message,
                    isUser: msg.isUser,
                    isTyping: isTyping,
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ask anything...',
                  filled: true,
                  fillColor: colors.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _send(),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: _sending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              onPressed: _sending ? null : _send,
            ),
          ],
        ),
      ],
    );
  }
}
