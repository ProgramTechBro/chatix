import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/searched_user_entity.dart';
import '../datasources/local/search_local_datasource.dart';
import '../repo/search_repository.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._localDataSource);

  final SearchLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<SearchedUserEntity>>> getRecentSearches() async {
    final users = await _localDataSource.getRecentSearches();
    return Right(List<SearchedUserEntity>.of(users));
  }

  @override
  Future<Either<Failure, List<SearchedUserEntity>>> searchUsers(String query) async {
    final users = await _localDataSource.searchUsers(query);
    return Right(List<SearchedUserEntity>.of(users));
  }

  @override
  Future<Either<Failure, void>> removeRecentSearch(String userId) async {
    await _localDataSource.removeRecentSearch(userId);
    return const Right(null);
  }
}
