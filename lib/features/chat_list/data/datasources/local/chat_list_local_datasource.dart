import '../../models/chat_summary_model.dart';

abstract class ChatListLocalDataSource {
  List<ChatSummaryModel> getCached();

  Future<void> saveCache(List<ChatSummaryModel> chats);
}
