import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_header_entity.dart';
import '../entities/message_entity.dart';
import '../params/send_message_params.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> watchMessages(String conversationId);

  Future<Either<Failure, void>> sendMessage(SendMessageParams params);

  Future<Either<Failure, String>> uploadChatMedia(
    String conversationId,
    File file,
  );

  Stream<ChatHeaderEntity> watchConversationHeader(String conversationId);

  Future<Either<Failure, void>> markConversationRead(String conversationId);
}
