import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../../domain/repositories/chat_list_repository.dart';
import '../datasources/local/chat_list_local_datasource.dart';
import '../datasources/remote/chat_list_remote_datasource.dart';

@LazySingleton(as: ChatListRepository)
class ChatListRepositoryImpl implements ChatListRepository {
  const ChatListRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final ChatListRemoteDataSource _remoteDataSource;
  final ChatListLocalDataSource _localDataSource;

  @override
  Stream<List<ChatSummaryEntity>> watchChatList() async* {
    final cached = _localDataSource.getCached();
    if (cached.isNotEmpty) yield cached;

    yield* _remoteDataSource.watchChatList().map((chats) {
      unawaited(_localDataSource.saveCache(chats));
      return List<ChatSummaryEntity>.of(chats);
    });
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
