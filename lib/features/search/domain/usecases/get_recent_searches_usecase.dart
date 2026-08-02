import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/searched_user_entity.dart';
import '../repositories/search_repository.dart';

@injectable
class GetRecentSearchesUseCase {
  const GetRecentSearchesUseCase(this._repository);

  final SearchRepository _repository;

  Future<Either<Failure, List<SearchedUserEntity>>> call() =>
      _repository.getRecentSearches();
}
