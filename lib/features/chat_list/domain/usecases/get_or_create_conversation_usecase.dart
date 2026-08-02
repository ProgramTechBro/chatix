import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_list_repository.dart';

@injectable
class GetOrCreateConversationUseCase {
  const GetOrCreateConversationUseCase(this._repository);

  final ChatListRepository _repository;

  Future<Either<Failure, String>> call(String otherUserId) {
    return _repository.getOrCreateConversation(otherUserId);
  }
}
