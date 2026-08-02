import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_summary_entity.dart';

abstract class ChatListRepository {
  Stream<List<ChatSummaryEntity>> watchChatList();

  Future<Either<Failure, String>> getOrCreateConversation(String otherUserId);
}
