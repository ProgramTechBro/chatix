import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/search_repository.dart';
import '../entities/searched_user_entity.dart';

@injectable
class SearchUsersUseCase {
  const SearchUsersUseCase(this._repository);

  final SearchRepository _repository;

  Future<Either<Failure, List<SearchedUserEntity>>> call(String query) => _repository.searchUsers(query);
}
