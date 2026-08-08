import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../../../core/shared_widgets/app_error_view.dart';
import '../../../../core/shared_widgets/app_loader.dart';
import '../../../../core/utils/helpers/debouncer.dart';
import '../../../../routes/app_routes.dart';
import '../../../chat_list/domain/usecases/get_or_create_conversation_usecase.dart';
import '../providers/search_provider.dart';
import 'local_widgets/search_result_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer();

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  Future<void> _startChat(String otherUserId) async {
    final result = await getIt<GetOrCreateConversationUseCase>().call(
      otherUserId,
    );
    if (!mounted) return;
    result.fold(
      (failure) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message))),
      (conversationId) =>
          context.push(AppRoutes.chatDetailPath(conversationId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchControllerProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  const AppBackButton(),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: (query) => _debouncer.run(
                        () => ref
                            .read(searchControllerProvider.notifier)
                            .search(query),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: resultsAsync.when(
                data: (users) => users.isEmpty
                    ? Center(
                        child: Text(
                          'No users found',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return SearchResultTile(
                            user: user,
                            onTap: () => _startChat(user.id),
                            onRemove: () => ref
                                .read(searchControllerProvider.notifier)
                                .removeRecentSearch(user.id),
                          );
                        },
                      ),
                loading: () => const AppLoader(),
                error: (error, stackTrace) => const AppErrorView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
