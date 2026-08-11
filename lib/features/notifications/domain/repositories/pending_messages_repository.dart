import '../entities/pending_message_entity.dart';

abstract class PendingMessagesRepository {
  Future<void> add(String conversationId, PendingMessageEntity message);

  Future<List<PendingMessageEntity>> getAll(String conversationId);

  Future<void> clear(String conversationId);
}
