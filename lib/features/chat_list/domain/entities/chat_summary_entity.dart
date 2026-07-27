class ChatSummaryEntity {
  const ChatSummaryEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
  });

  final String id;
  final String userId;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
}
