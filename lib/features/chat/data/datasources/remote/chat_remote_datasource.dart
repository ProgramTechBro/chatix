import 'dart:io';

import '../../models/chat_header_model.dart';
import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<MessageModel>> watchMessages(String conversationId);

  Future<void> sendMessage({
    required String conversationId,
    required String type,
    String? text,
    String? mediaUrl,
    int? mediaDurationMs,
  });

  Future<String> uploadChatMedia(String conversationId, File file);

  Future<ChatHeaderModel> getConversationHeader(String conversationId);

  Future<void> markConversationRead(String conversationId);
}
