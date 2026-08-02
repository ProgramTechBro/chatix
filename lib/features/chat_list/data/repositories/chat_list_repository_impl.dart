import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../../domain/repositories/chat_list_repository.dart';
import '../datasources/remote/chat_list_remote_datasource.dart';

@LazySingleton(as: ChatListRepository)
class ChatListRepositoryImpl implements ChatListRepository {
  const ChatListRepositoryImpl(this._remoteDataSource);

  final ChatListRemoteDataSource _remoteDataSource;

  @override
  Stream<List<ChatSummaryEntity>> watchChatList() {
    return _remoteDataSource.watchChatList().map(List<ChatSummaryEntity>.of);
  }

  @override
  Future<Either<Failure, String>> getOrCreateConversation(
    String otherUserId,
  ) async {
    try {
      final conversationId = await _remoteDataSource
          .getOrCreateDirectConversation(otherUserId);
      return Right(conversationId);
    } catch (_) {
      return const Left(ServerFailure('Could not start conversation.'));
    }
  }
}
