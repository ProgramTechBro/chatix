import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../../../routes/app_routes.dart';
import '../../../videos/presentation/providers/videos_provider.dart';
import '../providers/profile_provider.dart';
import 'local_widgets/profile_header.dart';
import 'local_widgets/profile_photo_grid.dart';
import 'local_widgets/profile_post_grid.dart';
import 'local_widgets/profile_tab_bar.dart';
import 'local_widgets/profile_video_grid.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider(widget.userId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          profileAsync.when(
            data: (profile) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    profile: profile,
                    onEditProfile: () =>
                        context.push(AppRoutes.editProfilePath(widget.userId)),
                    onShareProfile: () {},
                    onFollowingTap: () =>
                        context.push(AppRoutes.followingPath(widget.userId)),
                    onFollowersTap: () =>
                        context.push(AppRoutes.followersPath(widget.userId)),
                    onPostsTap: () => context.push(
                      AppRoutes.profilePostsGridPath(widget.userId),
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyTabBarDelegate(
                      tabController: _tabController,
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      final postsAsync = ref.watch(
                        profilePostsProvider(widget.userId),
                      );
                      return postsAsync.when(
                        data: (posts) => _ProfileTabBody(
                          storageKey: 'posts',
                          child: ProfilePostGrid(
                            posts: posts,
                            onPostTap: (_) => context.push(
                              AppRoutes.profilePostsFeedPath(widget.userId),
                            ),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        error: (error, stackTrace) => const SizedBox.shrink(),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final photosAsync = ref.watch(
                        profilePhotosProvider(widget.userId),
                      );
                      return photosAsync.when(
                        data: (photos) => _ProfileTabBody(
                          storageKey: 'photos',
                          child: ProfilePhotoGrid(photoAssets: photos),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        error: (error, stackTrace) => const SizedBox.shrink(),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final videosAsync = ref.watch(videosProvider);
                      return videosAsync.when(
                        data: (videos) => _ProfileTabBody(
                          storageKey: 'videos',
                          child: ProfileVideoGrid(videos: videos),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        error: (error, stackTrace) => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            error: (error, stackTrace) => Center(
              child: Text('Something went wrong', style: textTheme.bodyMedium),
            ),
          ),
          // Positioned(
          //   top: MediaQuery.of(context).padding.top,
          //   left: 8,
          //   child: const AppBackButton(color: AppColors.white),
          // ),
        ],
      ),
    );
  }
}

class _ProfileTabBody extends StatelessWidget {
  const _ProfileTabBody({required this.storageKey, required this.child});

  final String storageKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => CustomScrollView(
        key: PageStorageKey<String>(storageKey),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(child: child),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate({required this.tabController});

  final TabController tabController;

  static const double _height = 64;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: AnimatedBuilder(
          animation: tabController,
          builder: (context, _) => ProfileTabBar(
            activeIndex: tabController.index,
            onChanged: tabController.animateTo,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return oldDelegate.tabController != tabController;
  }
}
