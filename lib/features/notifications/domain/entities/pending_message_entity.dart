import '../../../../core/enums/message_type.dart';

class PendingMessageEntity {
  const PendingMessageEntity({
    required this.messageId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.preview,
    required this.createdAt,
    required this.type,
    this.mediaUrl,
  });

  final String messageId;
  final String senderName;
  final String senderAvatarUrl;
  final String preview;
  final DateTime createdAt;
  final MessageType type;
  final String? mediaUrl;
}
