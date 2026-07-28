import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/message_entity.dart';
import '../datasources/local/chat_local_datasource.dart';
import '../repo/chat_repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._localDataSource);

  final ChatLocalDataSource _localDataSource;

  @override
  Stream<List<MessageEntity>> watchMessages(String chatId) {
    return _localDataSource.watchMessages(chatId).map((messages) => List<MessageEntity>.of(messages));
  }

  @override
  Future<Either<Failure, void>> sendMessage(String chatId, String text) async {
    await _localDataSource.sendMessage(chatId, text);
    return const Right(null);
  }
}
