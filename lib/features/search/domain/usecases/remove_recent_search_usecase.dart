import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/search_repository.dart';

@injectable
class RemoveRecentSearchUseCase {
  const RemoveRecentSearchUseCase(this._repository);

  final SearchRepository _repository;

  Future<Either<Failure, void>> call(String userId) => _repository.removeRecentSearch(userId);
}
