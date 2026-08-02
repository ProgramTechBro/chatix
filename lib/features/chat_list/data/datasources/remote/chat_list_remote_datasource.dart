import '../../models/chat_summary_model.dart';

abstract class ChatListRemoteDataSource {
  Stream<List<ChatSummaryModel>> watchChatList();

  Future<String> getOrCreateDirectConversation(String otherUserId);
}
