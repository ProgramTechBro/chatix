import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/searched_user_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchedUserEntity>>> getRecentSearches();
  Future<Either<Failure, List<SearchedUserEntity>>> searchUsers(String query);
  Future<Either<Failure, void>> removeRecentSearch(String userId);
}
