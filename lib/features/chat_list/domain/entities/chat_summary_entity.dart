class ChatSummaryEntity {
  const ChatSummaryEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.isOnline,
    required this.unreadCount,
  });

  final String id;
  final String userId;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final DateTime lastMessageAt;
  final bool isOnline;
  final int unreadCount;
}
