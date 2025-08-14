import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isTyping;
  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.isTyping = false,
  });

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
        child: isTyping
            ? SizedBox(
                width: 28,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _Dot(
                      color: isUser ? Colors.white : colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 3),
                    _Dot(
                      color: isUser ? Colors.white : colors.onSurfaceVariant,
                      delayMs: 150,
                    ),
                    const SizedBox(width: 3),
                    _Dot(
                      color: isUser ? Colors.white : colors.onSurfaceVariant,
                      delayMs: 300,
                    ),
                  ],
                ),
              )
            : Text(
                text,
                style: textStyle?.copyWith(color: isUser ? Colors.white : null),
              ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final Color color;
  final int delayMs;
  const _Dot({required this.color, this.delayMs = 0});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _animation = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.delayMs > 0) {
      _controller.stop();
      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) _controller.repeat();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
