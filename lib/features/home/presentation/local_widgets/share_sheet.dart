import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../providers/share_contacts_provider.dart';

Future<void> showShareSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const ShareSheet(),
  );
}

class ShareSheet extends ConsumerWidget {
  const ShareSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(shareContactsProvider);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(100)),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text('Share', style: textTheme.titleSmall)),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(hintText: 'Search', prefixIcon: Icon(Icons.search_rounded)),
            ),
            const SizedBox(height: 16),
            Text('Share with', style: textTheme.bodyMedium?.copyWith(fontSize: 17)),
            const SizedBox(height: 8),
            SizedBox(
              height: 76,
              child: contactsAsync.when(
                data: (contacts) => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: contacts.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return SizedBox(
                      width: 53,
                      child: Column(
                        children: [
                          CircleAvatar(radius: 25, backgroundImage: NetworkImage(contact.avatarUrl)),
                          const SizedBox(height: 8),
                          Text(
                            contact.name,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 16),
            Text('Send to', style: textTheme.bodyMedium?.copyWith(fontSize: 17)),
            const SizedBox(height: 8),
            Row(
              children: [
                _SendToIconButton(icon: AppIcons.postSend, label: 'Chat'),
                const SizedBox(width: 20),
                _SendToIconButton(icon: AppIcons.shareWhatsapp, label: 'WhatsApp'),
                const SizedBox(width: 20),
                _SendToIconButton(icon: AppIcons.shareFacebook, label: 'Facebook'),
                const SizedBox(width: 20),
                _SendToIconButton(icon: null, materialIcon: Icons.link, label: 'Link'),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Write a message...',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Share to your profile',
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Shared to your profile')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SendToIconButton extends StatelessWidget {
  const _SendToIconButton({required this.label, this.icon, this.materialIcon});

  final String label;
  final String? icon;
  final IconData? materialIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Shared via $label')));
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
        child: Center(
          child: icon != null
              ? SvgPicture.asset(
                  icon!,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                )
              : Icon(materialIcon, size: 24, color: AppColors.black),
        ),
      ),
    );
  }
}
