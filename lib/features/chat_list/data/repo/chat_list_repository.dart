import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_summary_entity.dart';

abstract class ChatListRepository {
  Future<Either<Failure, List<ChatSummaryEntity>>> getChatList();
}
