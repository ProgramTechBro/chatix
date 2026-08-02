import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

@injectable
class MarkConversationReadUseCase {
  const MarkConversationReadUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, void>> call(String conversationId) {
    return _repository.markConversationRead(conversationId);
  }
}
