import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> watchMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(String chatId, String text);
}
