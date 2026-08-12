import '../../models/chat_header_model.dart';

abstract class ChatHeaderLocalDataSource {
  ChatHeaderModel? getCached(String conversationId);

  Future<void> saveCache(String conversationId, ChatHeaderModel header);
}
