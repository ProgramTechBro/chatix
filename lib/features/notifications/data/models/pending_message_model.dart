import '../../domain/entities/pending_message_entity.dart';

class PendingMessageModel extends PendingMessageEntity {
  const PendingMessageModel({
    required super.messageId,
    required super.senderName,
    required super.senderAvatarUrl,
    required super.preview,
    required super.createdAt,
  });

  factory PendingMessageModel.fromJson(Map<String, dynamic> json) {
    return PendingMessageModel(
      messageId: json['message_id'] as String,
      senderName: json['sender_name'] as String,
      senderAvatarUrl: json['sender_avatar_url'] as String,
      preview: json['preview'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_name': senderName,
      'sender_avatar_url': senderAvatarUrl,
      'preview': preview,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
