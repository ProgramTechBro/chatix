import '../../domain/entities/chat_header_entity.dart';

class ChatHeaderModel extends ChatHeaderEntity {
  const ChatHeaderModel({
    required super.conversationId,
    required super.otherUserId,
    required super.name,
    required super.avatarUrl,
    required super.isOnline,
    super.lastSeenAt,
  });

  factory ChatHeaderModel.fromJson(Map<String, dynamic> json) {
    return ChatHeaderModel(
      conversationId: json['conversation_id'] as String,
      otherUserId: json['other_user_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      isOnline: json['is_online'] as bool,
      lastSeenAt: json['last_seen_at'] != null
          ? DateTime.parse(json['last_seen_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'other_user_id': otherUserId,
      'name': name,
      'avatar_url': avatarUrl,
      'is_online': isOnline,
      'last_seen_at': lastSeenAt?.toIso8601String(),
    };
  }
}
