import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_header_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/params/send_message_params.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/remote/chat_remote_datasource.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Stream<List<MessageEntity>> watchMessages(String conversationId) {
    return _remoteDataSource
        .watchMessages(conversationId)
        .map(List<MessageEntity>.of);
  }

  @override
  Future<Either<Failure, void>> sendMessage(SendMessageParams params) async {
    try {
      await _remoteDataSource.sendMessage(
        conversationId: params.conversationId,
        type: params.type.name,
        text: params.text,
        mediaUrl: params.mediaUrl,
        mediaDurationMs: params.mediaDurationMs,
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
  Stream<ChatHeaderEntity> watchConversationHeader(String conversationId) {
    return _remoteDataSource.watchConversationHeader(conversationId);
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
