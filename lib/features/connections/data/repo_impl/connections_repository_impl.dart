import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/connection_entity.dart';
import '../datasources/local/connections_local_datasource.dart';
import '../repo/connections_repository.dart';

@LazySingleton(as: ConnectionsRepository)
class ConnectionsRepositoryImpl implements ConnectionsRepository {
  const ConnectionsRepositoryImpl(this._localDataSource);

  final ConnectionsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<ConnectionEntity>>> getFollowing(String userId) async {
    final connections = await _localDataSource.getFollowing(userId);
    return Right(List<ConnectionEntity>.of(connections));
  }

  @override
  Future<Either<Failure, List<ConnectionEntity>>> getFollowers(String userId) async {
    final connections = await _localDataSource.getFollowers(userId);
    return Right(List<ConnectionEntity>.of(connections));
  }
}
