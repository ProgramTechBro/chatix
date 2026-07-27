import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import '../../home/presentation/local_widgets/post_card.dart';
import '../../home/presentation/local_widgets/post_options_menu.dart';
import '../../home/presentation/local_widgets/send_to_sheet.dart';
import '../../home/presentation/local_widgets/share_sheet.dart';
import '../../videos/presentation/providers/videos_provider.dart';
import 'local_widgets/profile_header.dart';
import 'local_widgets/profile_photo_grid.dart';
import 'local_widgets/profile_tab_bar.dart';
import 'local_widgets/profile_video_grid.dart';
import 'providers/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider(widget.userId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          profileAsync.when(
            data: (profile) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileHeader(profile: profile, onEditProfile: () {}, onShareProfile: () {}),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileTabBar(
                      activeIndex: _activeTab,
                      onChanged: (index) => setState(() => _activeTab = index),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: _buildTabContent(widget.userId)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (error, stackTrace) => Center(
              child: Text('Something went wrong', style: textTheme.bodyMedium),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 8,
            child: const AppBackButton(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String userId) {
    switch (_activeTab) {
      case 1:
        return Consumer(
          builder: (context, ref, _) {
            final photosAsync = ref.watch(profilePhotosProvider(userId));
            return photosAsync.when(
              data: (photos) => ProfilePhotoGrid(photoAssets: photos),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              ),
              error: (error, stackTrace) => const SizedBox.shrink(),
            );
          },
        );
      case 2:
        return Consumer(
          builder: (context, ref, _) {
            final videosAsync = ref.watch(videosProvider);
            return videosAsync.when(
              data: (videos) => ProfileVideoGrid(videos: videos),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              ),
              error: (error, stackTrace) => const SizedBox.shrink(),
            );
          },
        );
      default:
        return Consumer(
          builder: (context, ref, _) {
            final postsAsync = ref.watch(profilePostsProvider(userId));
            return postsAsync.when(
              data: (posts) => Column(
                children: [
                  for (final post in posts)
                    PostCard(
                      post: post,
                      onSendTap: () => showSendToSheet(context),
                      onShareTap: () => showShareSheet(context),
                      onMoreTap: (position) => showPostOptionsMenu(context, post.id, position),
                    ),
                ],
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              ),
              error: (error, stackTrace) => const SizedBox.shrink(),
            );
          },
        );
    }
  }
}
