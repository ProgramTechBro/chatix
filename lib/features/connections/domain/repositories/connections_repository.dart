import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/connection_entity.dart';

abstract class ConnectionsRepository {
  Future<Either<Failure, List<ConnectionEntity>>> getFollowing(String userId);
  Future<Either<Failure, List<ConnectionEntity>>> getFollowers(String userId);
}
