import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../config/app_assets.dart';
import '../../../../../config/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.userName,
    this.onAvatarTap,
    this.onSearchTap,
    this.onMessageTap,
    this.onAddTap,
  });

  final String userName;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    AppNetworkImages.currentUserAvatar,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          _TopBarIconButton(icon: AppIcons.homeSearch, onTap: onSearchTap),
          const SizedBox(width: 16),
          _TopBarIconButton(icon: AppIcons.homeMessage, onTap: onMessageTap),
          const SizedBox(width: 16),
          _TopBarIconButton(icon: AppIcons.homeAddPost, onTap: onAddTap),
        ],
      ),
    );
  }
}

class _TopBarIconButton extends StatelessWidget {
  const _TopBarIconButton({required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
      ),
    );
  }
}
