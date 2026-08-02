import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../routes/app_routes.dart';
import '../providers/feed_provider.dart';
import 'local_widgets/home_top_bar.dart';
import 'local_widgets/post_card.dart';
import 'local_widgets/post_options_menu.dart';
import 'local_widgets/send_to_sheet.dart';
import 'local_widgets/share_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedControllerProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Chatix', style: textTheme.titleLarge),
              ),
            ),
            HomeTopBar(
              userName: 'Jack miller',
              onAvatarTap: () => context.push(AppRoutes.profilePath('me')),
              onSearchTap: () => context.push(AppRoutes.search),
              onMessageTap: () => context.push(AppRoutes.chats),
              onAddTap: () => context.push(AppRoutes.createPost),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.divider, height: 1, thickness: 1),
            Expanded(
              child: feedAsync.when(
                data: (posts) => ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostCard(
                      post: post,
                      onAuthorTap: () =>
                          context.push(AppRoutes.profilePath(post.authorId)),
                      onLikeTap: () => ref
                          .read(feedControllerProvider.notifier)
                          .toggleLike(post.id),
                      onCommentTap: () =>
                          context.push(AppRoutes.postDetailPath(post.id)),
                      onSendTap: () => showSendToSheet(context),
                      onShareTap: () => showShareSheet(context),
                      onMoreTap: (position) =>
                          showPostOptionsMenu(context, post.id, position),
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Something went wrong',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
