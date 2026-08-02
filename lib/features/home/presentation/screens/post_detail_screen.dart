import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../providers/comments_provider.dart';
import '../providers/feed_provider.dart';
import 'local_widgets/comment_input_bar.dart';
import 'local_widgets/comment_tile.dart';
import 'local_widgets/post_card.dart';
import 'local_widgets/post_options_menu.dart';
import 'local_widgets/send_to_sheet.dart';
import 'local_widgets/share_sheet.dart';

class PostDetailScreen extends ConsumerWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedControllerProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: feedAsync.when(
          data: (posts) {
            final post = posts.firstWhere(
              (post) => post.id == postId,
              orElse: () => posts.first,
            );

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppBackButton(),
                  ),
                ),
                PostCard(
                  post: post,
                  onLikeTap: () => ref
                      .read(feedControllerProvider.notifier)
                      .toggleLike(post.id),
                  onSendTap: () => showSendToSheet(context),
                  onShareTap: () => showShareSheet(context),
                  onMoreTap: (position) =>
                      showPostOptionsMenu(context, post.id, position),
                ),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, _) {
                      final commentsAsync = ref.watch(
                        postCommentsProvider(postId),
                      );
                      return commentsAsync.when(
                        data: (comments) => ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: comments.length,
                          itemBuilder: (context, index) =>
                              CommentTile(comment: comments[index]),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text(
                            'Something went wrong',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: CommentInputBar(),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Something went wrong', style: textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }
}
