import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/post_media_type.dart';
import '../../../home/domain/entities/post_entity.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({super.key, required this.posts, this.onPostTap});

  final List<PostEntity> posts;
  final ValueChanged<int>? onPostTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisCount = 3;
          const spacing = 8.0;
          final cellWidth = (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: cellWidth / 120,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return GestureDetector(
                onTap: () => onPostTap?.call(index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(post.imageAsset, fit: BoxFit.cover),
                      if (post.mediaType == PostMediaType.video)
                        Positioned(
                          left: 8,
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.black.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow_rounded, size: 24, color: AppColors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
