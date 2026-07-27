import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/chat_list_repository.dart';
import '../entities/chat_summary_entity.dart';

@injectable
class GetChatListUseCase {
  const GetChatListUseCase(this._repository);

  final ChatListRepository _repository;

  Future<Either<Failure, List<ChatSummaryEntity>>> call() => _repository.getChatList();
}
