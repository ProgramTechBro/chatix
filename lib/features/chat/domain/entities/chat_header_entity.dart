class ChatHeaderEntity {
  const ChatHeaderEntity({
    required this.conversationId,
    required this.otherUserId,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
    this.lastSeenAt,
  });

  final String conversationId;
  final String otherUserId;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final DateTime? lastSeenAt;
}
