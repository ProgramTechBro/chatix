import '../../../../core/enums/message_status.dart';
import '../../../../core/enums/message_type.dart';

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    this.text,
    this.mediaUrl,
    this.mediaDurationMs,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final MessageType type;
  final String? text;
  final String? mediaUrl;
  final int? mediaDurationMs;
  final MessageStatus status;
  final DateTime createdAt;
}
