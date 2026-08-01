import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/profile_post_grid.dart';
import 'providers/profile_provider.dart';

class ProfilePostsGridScreen extends ConsumerWidget {
  const ProfilePostsGridScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(profilePostsProvider(userId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text('Posts', style: textTheme.titleSmall),
                  const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            Expanded(
              child: postsAsync.when(
                data: (posts) => SingleChildScrollView(
                  child: ProfilePostGrid(
                    posts: posts,
                    onPostTap: (_) => context.push(AppRoutes.profilePostsFeedPath(userId)),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (error, stackTrace) => Center(
                  child: Text('Something went wrong', style: textTheme.bodyMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
