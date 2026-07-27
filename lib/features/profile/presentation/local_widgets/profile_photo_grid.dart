import 'package:flutter/material.dart';

class ProfilePhotoGrid extends StatelessWidget {
  const ProfilePhotoGrid({super.key, required this.photoAssets});

  final List<String> photoAssets;

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
            itemCount: photoAssets.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(photoAssets[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
