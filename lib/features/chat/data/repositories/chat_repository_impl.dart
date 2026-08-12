import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_header_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/params/send_message_params.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/local/chat_header_local_datasource.dart';
import '../datasources/local/chat_local_datasource.dart';
import '../datasources/remote/chat_remote_datasource.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._headerLocalDataSource,
  );

  final ChatRemoteDataSource _remoteDataSource;
  final ChatLocalDataSource _localDataSource;
  final ChatHeaderLocalDataSource _headerLocalDataSource;

  @override
  Stream<List<MessageEntity>> watchMessages(String conversationId) async* {
    final cached = _localDataSource.getCached(conversationId);
    if (cached.isNotEmpty) yield cached;

    yield* _remoteDataSource.watchMessages(conversationId).map((messages) {
      unawaited(_localDataSource.saveCache(conversationId, messages));
      return List<MessageEntity>.of(messages);
    });
  }

  @override
  Future<Either<Failure, void>> sendMessage(SendMessageParams params) async {
    try {
      await _remoteDataSource.sendMessage(
        id: params.id,
        conversationId: params.conversationId,
        type: params.type.name,
        text: params.text,
        mediaUrl: params.mediaUrl,
        mediaDurationMs: params.mediaDurationMs,
        waveformSamples: params.waveformSamples,
        blurHash: params.blurHash,
      );
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure('Could not send message.'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadChatMedia(
    String conversationId,
    File file,
  ) async {
    try {
      final url = await _remoteDataSource.uploadChatMedia(conversationId, file);
      return Right(url);
    } catch (_) {
      return const Left(ServerFailure('Could not upload media.'));
    }
  }

  @override
  Stream<ChatHeaderEntity> watchConversationHeader(
    String conversationId,
  ) async* {
    final cached = _headerLocalDataSource.getCached(conversationId);
    if (cached != null) yield cached;

    yield* _remoteDataSource.watchConversationHeader(conversationId).map((
      header,
    ) {
      unawaited(_headerLocalDataSource.saveCache(conversationId, header));
      return header;
    });
  }

  @override
  Future<Either<Failure, void>> markConversationRead(
    String conversationId,
  ) async {
    try {
      await _remoteDataSource.markConversationRead(conversationId);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure('Could not update read status.'));
    }
  }
}
