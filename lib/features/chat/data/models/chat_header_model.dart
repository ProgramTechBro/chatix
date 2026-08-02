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
}
