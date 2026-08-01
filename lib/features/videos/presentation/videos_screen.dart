import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/videos_tab.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import 'local_widgets/reels_page_view.dart';
import 'providers/videos_provider.dart';
import 'providers/videos_tab_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(videosProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          videosAsync.when(
            data: (videos) => ReelsPageView(videos: videos),
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.white)),
            error: (error, stackTrace) => Center(
              child: Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 8,
            child: const AppBackButton(color: AppColors.white),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 0,
            right: 0,
            child: const Center(child: _VideosTabToggle()),
          ),
        ],
      ),
    );
  }
}

class _VideosTabToggle extends ConsumerWidget {
  const _VideosTabToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(videosTabSelectionProvider);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TabLabel(
          label: 'For you',
          isSelected: selectedTab == VideosTab.forYou,
          textTheme: textTheme,
          onTap: () => ref.read(videosTabSelectionProvider.notifier).select(VideosTab.forYou),
        ),
        const SizedBox(width: 24),
        _TabLabel(
          label: 'Following',
          isSelected: selectedTab == VideosTab.following,
          textTheme: textTheme,
          onTap: () => ref.read(videosTabSelectionProvider.notifier).select(VideosTab.following),
        ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.isSelected,
    required this.textTheme,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: textTheme.titleSmall?.copyWith(color: isSelected ? AppColors.primary : AppColors.white),
      ),
    );
  }
}
