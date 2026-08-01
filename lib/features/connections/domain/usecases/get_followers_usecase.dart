import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/connections_repository.dart';
import '../entities/connection_entity.dart';

@injectable
class GetFollowersUseCase {
  const GetFollowersUseCase(this._repository);

  final ConnectionsRepository _repository;

  Future<Either<Failure, List<ConnectionEntity>>> call(String userId) => _repository.getFollowers(userId);
}
