import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import 'local_widgets/reels_page_view.dart';
import 'providers/videos_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(videosProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: videosAsync.when(
        data: (videos) => ReelsPageView(videos: videos),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.white)),
        error: (error, stackTrace) => Center(
          child: Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
