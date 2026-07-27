import '../../domain/entities/chat_summary_entity.dart';

class ChatSummaryModel extends ChatSummaryEntity {
  const ChatSummaryModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.avatarUrl,
    required super.lastMessage,
    required super.time,
  });
}
