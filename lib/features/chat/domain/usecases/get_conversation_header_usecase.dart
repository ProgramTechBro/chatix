import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_header_entity.dart';
import '../repositories/chat_repository.dart';

@injectable
class GetConversationHeaderUseCase {
  const GetConversationHeaderUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, ChatHeaderEntity>> call(String conversationId) {
    return _repository.getConversationHeader(conversationId);
  }
}
