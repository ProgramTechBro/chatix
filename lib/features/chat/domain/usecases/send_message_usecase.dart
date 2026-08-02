import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/message_type.dart';
import '../../../../core/errors/failures.dart';
import '../params/send_message_params.dart';
import '../repositories/chat_repository.dart';

@injectable
class SendMessageUseCase {
  const SendMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, void>> call({
    required String conversationId,
    required String text,
  }) {
    return _repository.sendMessage(
      SendMessageParams(
        conversationId: conversationId,
        type: MessageType.text,
        text: text,
      ),
    );
  }
}
