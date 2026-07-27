import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../datasources/local/chat_list_local_datasource.dart';
import '../repo/chat_list_repository.dart';

@LazySingleton(as: ChatListRepository)
class ChatListRepositoryImpl implements ChatListRepository {
  const ChatListRepositoryImpl(this._localDataSource);

  final ChatListLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<ChatSummaryEntity>>> getChatList() async {
    final chats = await _localDataSource.getChatList();
    return Right(List<ChatSummaryEntity>.of(chats));
  }
}
