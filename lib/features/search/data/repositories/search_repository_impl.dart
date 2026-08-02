import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/searched_user_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/remote/search_remote_datasource.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._remoteDataSource);

  final SearchRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<SearchedUserEntity>>> getRecentSearches() async {
    try {
      final users = await _remoteDataSource.getRecentSearches();
      return Right(List<SearchedUserEntity>.of(users));
    } catch (_) {
      return const Left(ServerFailure('Could not load users.'));
    }
  }

  @override
  Future<Either<Failure, List<SearchedUserEntity>>> searchUsers(
    String query,
  ) async {
    try {
      final users = await _remoteDataSource.searchUsers(query);
      return Right(List<SearchedUserEntity>.of(users));
    } catch (_) {
      return const Left(ServerFailure('Could not search users.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeRecentSearch(String userId) async {
    return const Right(null);
  }
}
