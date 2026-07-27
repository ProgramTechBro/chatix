import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/searched_user_entity.dart';
import '../../domain/usecases/get_recent_searches_usecase.dart';
import '../../domain/usecases/remove_recent_search_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';

part 'search_provider.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  Future<List<SearchedUserEntity>> build() async {
    final result = await getIt<GetRecentSearchesUseCase>().call();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (users) => users,
    );
  }

  Future<void> search(String query) async {
    state = const AsyncLoading<List<SearchedUserEntity>>().copyWithPrevious(state);
    final result = await getIt<SearchUsersUseCase>().call(query);
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (users) => AsyncData(users),
    );
  }

  Future<void> removeRecentSearch(String userId) async {
    final currentUsers = state.valueOrNull;
    if (currentUsers == null) return;

    final result = await getIt<RemoveRecentSearchUseCase>().call(userId);
    result.fold(
      (failure) => null,
      (_) => state = AsyncData([
        for (final user in currentUsers)
          if (user.id != userId) user,
      ]),
    );
  }
}
