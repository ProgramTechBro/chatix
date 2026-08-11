import '../../domain/entities/chat_summary_entity.dart';

class ChatSummaryModel extends ChatSummaryEntity {
  const ChatSummaryModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.avatarUrl,
    required super.lastMessage,
    required super.lastMessageAt,
    required super.isOnline,
    required super.unreadCount,
    super.lastSeenAt,
  });

  factory ChatSummaryModel.fromJson(Map<String, dynamic> json) {
    return ChatSummaryModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      lastMessage: json['last_message'] as String,
      lastMessageAt: DateTime.parse(json['last_message_at'] as String),
      isOnline: json['is_online'] as bool,
      unreadCount: json['unread_count'] as int,
      lastSeenAt: json['last_seen_at'] != null
          ? DateTime.parse(json['last_seen_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'avatar_url': avatarUrl,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt.toIso8601String(),
      'is_online': isOnline,
      'unread_count': unreadCount,
      'last_seen_at': lastSeenAt?.toIso8601String(),
    };
  }
}
