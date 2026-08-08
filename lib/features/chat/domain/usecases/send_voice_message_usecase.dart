import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/message_type.dart';
import '../../../../core/errors/failures.dart';
import '../params/send_message_params.dart';
import '../repositories/chat_repository.dart';

@injectable
class SendVoiceMessageUseCase {
  const SendVoiceMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, void>> call({
    required String conversationId,
    required File audioFile,
    required int durationMs,
  }) async {
    final uploadResult = await _repository.uploadChatMedia(
      conversationId,
      audioFile,
    );
    return uploadResult.fold(
      Left.new,
      (url) => _repository.sendMessage(
        SendMessageParams(
          conversationId: conversationId,
          type: MessageType.voice,
          mediaUrl: url,
          mediaDurationMs: durationMs,
        ),
      ),
    );
  }
}
