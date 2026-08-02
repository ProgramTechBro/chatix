import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/connection_entity.dart';
import '../../domain/usecases/get_followers_usecase.dart';
import '../../domain/usecases/get_following_usecase.dart';

part 'connections_provider.g.dart';

@riverpod
Future<List<ConnectionEntity>> followingList(
  FollowingListRef ref,
  String userId,
) async {
  final result = await getIt<GetFollowingUseCase>().call(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (connections) => connections,
  );
}

@riverpod
Future<List<ConnectionEntity>> followersList(
  FollowersListRef ref,
  String userId,
) async {
  final result = await getIt<GetFollowersUseCase>().call(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (connections) => connections,
  );
}
