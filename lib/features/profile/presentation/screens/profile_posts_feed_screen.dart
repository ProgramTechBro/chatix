import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../../home/presentation/screens/local_widgets/post_card.dart';
import '../../../home/presentation/screens/local_widgets/post_options_menu.dart';
import '../../../home/presentation/screens/local_widgets/send_to_sheet.dart';
import '../../../home/presentation/screens/local_widgets/share_sheet.dart';
import '../providers/profile_provider.dart';

class ProfilePostsFeedScreen extends ConsumerWidget {
  const ProfilePostsFeedScreen({super.key, required this.userId});

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
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(),
              ),
            ),
            Expanded(
              child: postsAsync.when(
                data: (posts) => ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostCard(
                      post: post,
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
