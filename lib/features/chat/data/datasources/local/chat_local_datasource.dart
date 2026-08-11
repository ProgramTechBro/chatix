import '../../models/message_model.dart';

abstract class ChatLocalDataSource {
  List<MessageModel> getCached(String conversationId);

  Future<void> saveCache(String conversationId, List<MessageModel> messages);
}
