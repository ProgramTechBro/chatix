import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required this.name,
    required this.avatarUrl,
    this.onAvatarTap,
    this.onCallTap,
    this.onVideoCallTap,
  });

  final String name;
  final String avatarUrl;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCallTap;
  final VoidCallback? onVideoCallTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const AppBackButton(),
          GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onAvatarTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(name.split(' ').first, style: textTheme.bodySmall),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onCallTap,
            icon: const Icon(Icons.call_outlined, color: AppColors.black),
          ),
          IconButton(
            onPressed: onVideoCallTap,
            icon: const Icon(Icons.videocam_outlined, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
