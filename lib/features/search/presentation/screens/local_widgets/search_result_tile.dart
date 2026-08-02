import 'package:flutter/material.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/shared_widgets/app_avatar.dart';
import '../../../domain/entities/searched_user_entity.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.user,
    required this.onTap,
    required this.onRemove,
  });

  final SearchedUserEntity user;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            AppAvatar(
              imageUrl: user.avatarUrl,
              radius: 16,
              isOnline: user.isOnline,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                user.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                size: 24,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
