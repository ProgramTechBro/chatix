import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/message_type.dart';
import '../../../../core/errors/failures.dart';
import '../params/send_message_params.dart';
import '../repositories/chat_repository.dart';

@injectable
class SendImageMessageUseCase {
  const SendImageMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, void>> call({
    required String id,
    required String conversationId,
    required File imageFile,
  }) async {
    final uploadResult = await _repository.uploadChatMedia(
      conversationId,
      imageFile,
    );
    return uploadResult.fold(
      Left.new,
      (url) => _repository.sendMessage(
        SendMessageParams(
          id: id,
          conversationId: conversationId,
          type: MessageType.image,
          mediaUrl: url,
        ),
      ),
    );
  }
}
