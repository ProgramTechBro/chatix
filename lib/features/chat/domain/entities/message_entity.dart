class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.text,
    required this.isMine,
    required this.time,
  });

  final String id;
  final String text;
  final bool isMine;
  final String time;
}
