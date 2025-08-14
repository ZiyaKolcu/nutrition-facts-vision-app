class ChatMessage {
  final String id;
  final String role; 
  final String message;
  final DateTime? timestamp;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.message,
    required this.timestamp,
  });

  bool get isUser => role.toLowerCase() == 'user';

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: (json['id'] ?? '') as String,
      role: (json['role'] ?? '') as String,
      message: (json['message'] ?? '') as String,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String)
          : null,
    );
  }
}
