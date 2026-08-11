class PendingMessageEntity {
  const PendingMessageEntity({
    required this.messageId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.preview,
    required this.createdAt,
  });

  final String messageId;
  final String senderName;
  final String senderAvatarUrl;
  final String preview;
  final DateTime createdAt;
}
