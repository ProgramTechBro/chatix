class NotificationEntity {
  const NotificationEntity({
    required this.id,
    required this.avatarUrl,
    required this.title,
    required this.message,
    required this.time,
  });

  final String id;
  final String avatarUrl;
  final String title;
  final String message;
  final String time;
}
