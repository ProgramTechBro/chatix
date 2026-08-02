import 'package:flutter/material.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/shared_widgets/app_outlined_button.dart';
import '../../../../../core/utils/helpers/formatters.dart';
import '../../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    this.onEditProfile,
    this.onShareProfile,
    this.onFollowingTap,
    this.onFollowersTap,
    this.onPostsTap,
  });

  final ProfileEntity profile;
  final VoidCallback? onEditProfile;
  final VoidCallback? onShareProfile;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onPostsTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              profile.coverAsset,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 120,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: AppColors.white, width: 4),
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        profile.avatarAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.25),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.photo_library_outlined,
                        size: 24,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 96),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                profile.name,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                profile.bio,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatColumn(
                    value: formatCompactCount(profile.followingCount),
                    label: 'Following',
                    onTap: onFollowingTap,
                  ),
                  const SizedBox(width: 36),
                  _StatColumn(
                    value: formatCompactCount(profile.followersCount),
                    label: 'Followers',
                    onTap: onFollowersTap,
                  ),
                  const SizedBox(width: 36),
                  _StatColumn(
                    value: '${profile.postsCount}',
                    label: 'Posts',
                    onTap: onPostsTap,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppOutlinedButton(
                    label: 'Edit profile',
                    onPressed: onEditProfile,
                  ),
                  const SizedBox(width: 16),
                  AppOutlinedButton(
                    label: 'Share Profile',
                    onPressed: onShareProfile,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label, this.onTap});

  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(value, style: textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
