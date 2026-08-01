import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import 'providers/profile_provider.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(userId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text('Edit profile', style: textTheme.titleSmall),
                  const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                ],
              ),
            ),
            Expanded(
              child: profileAsync.when(
                data: (profile) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 8),
                    _EditFieldHeader(label: 'Profile Name', onEditTap: () {}),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(radius: 40, backgroundImage: AssetImage(profile.avatarAsset)),
                        const SizedBox(width: 16),
                        Expanded(child: Text(profile.name, style: textTheme.titleMedium)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 24),
                    _EditFieldHeader(label: 'Cover photo', onEditTap: () {}),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(profile.coverAsset, height: 200, width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 24),
                    _EditFieldHeader(label: 'Bio', onEditTap: () {}),
                    const SizedBox(height: 16),
                    Text(profile.bio, style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 24),
                    _EditFieldHeader(label: 'Birth date', onEditTap: () {}),
                    const SizedBox(height: 16),
                    Text(profile.birthDate, style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 24),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (error, stackTrace) => Center(
                  child: Text('Something went wrong', style: textTheme.bodyMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditFieldHeader extends StatelessWidget {
  const _EditFieldHeader({required this.label, required this.onEditTap});

  final String label;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.labelLarge?.copyWith(color: AppColors.black)),
        GestureDetector(
          onTap: onEditTap,
          child: Text('Edit', style: textTheme.labelLarge?.copyWith(color: AppColors.primary)),
        ),
      ],
    );
  }
}
