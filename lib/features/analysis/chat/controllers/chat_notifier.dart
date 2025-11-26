import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/api_base.dart';
import '../../../../core/localization/locale_provider.dart';
import '../models/chat_message.dart';

final _baseUrlProvider = Provider<String>((ref) => getApiBase());

final chatMessagesProvider =
    StateNotifierProvider.family<
      ChatNotifier,
      AsyncValue<List<ChatMessage>>,
      String
    >((ref, scanId) {
      return ChatNotifier(ref: ref, scanId: scanId)..fetchHistory();
    });

class ChatNotifier extends StateNotifier<AsyncValue<List<ChatMessage>>> {
  final Ref ref;
  final String scanId;

  ChatNotifier({required this.ref, required this.scanId})
    : super(const AsyncValue.loading());

  List<ChatMessage> _sortByTimestampAscending(List<ChatMessage> messages) {
    final sorted = List<ChatMessage>.from(messages);
    sorted.sort((a, b) {
      final ta = a.timestamp;
      final tb = b.timestamp;
      if (ta == null && tb == null) return 0;
      if (ta == null) return -1;
      if (tb == null) return 1;
      return ta.compareTo(tb);
    });
    return sorted;
  }

  Future<void> fetchHistory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) {
        throw Exception('No idToken');
      }

      final baseUrl = ref.read(_baseUrlProvider);
      final uri = Uri.parse('$baseUrl/chat/$scanId');
      final res = await http
          .get(
            uri,
            headers: {
              'Authorization': 'Bearer $idToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 20));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List<dynamic> list = json.decode(res.body) as List<dynamic>;
        final messages = _sortByTimestampAscending(
          list
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
        state = AsyncValue.data(messages);
      } else {
        throw Exception('Failed to fetch chat history');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    final current = state.value ?? <ChatMessage>[];
    final tempUserMessage = ChatMessage(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      role: 'user',
      message: text,
      timestamp: DateTime.now(),
    );
    final typingPlaceholder = ChatMessage(
      id: 'typing-${DateTime.now().millisecondsSinceEpoch}',
      role: 'assistant',
      message: 'Assistant is typing…',
      timestamp: DateTime.now(),
    );
    state = AsyncValue.data([...current, tempUserMessage, typingPlaceholder]);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) {
        throw Exception('No idToken');
      }

      final locale = ref.read(localeProvider);
      final language = locale.languageCode;

      final baseUrl = ref.read(_baseUrlProvider);
      final payload = <String, dynamic>{'message': text, 'language': language};
      final uri = Uri.parse('$baseUrl/chat/$scanId');
      final res = await http
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $idToken',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 30));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        await fetchHistory();
      } else {
        await fetchHistory();
      }
    } catch (e, st) {
      await fetchHistory();
      state = AsyncValue.error(e, st);
    }
  }
}
