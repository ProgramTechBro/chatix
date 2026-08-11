import '../../models/pending_message_model.dart';

abstract class PendingMessageLocalDataSource {
  Future<void> add(String conversationId, PendingMessageModel message);

  Future<List<PendingMessageModel>> getAll(String conversationId);

  Future<void> clear(String conversationId);
}
