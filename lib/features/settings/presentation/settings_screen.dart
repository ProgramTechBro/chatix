import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import 'local_widgets/settings_item_data.dart';
import 'local_widgets/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text('Settings', style: textTheme.titleSmall),
                  const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                children: [
                  SettingsSection(
                    title: 'Activity',
                    items: [
                      SettingsItemData(icon: Icons.account_circle_outlined, label: 'Personal information', onTap: () {}),
                      SettingsItemData(icon: Icons.bookmark_outline, label: 'Saved', onTap: () {}),
                      SettingsItemData(icon: Icons.block_outlined, label: 'Blocked', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SettingsSection(
                    title: 'Support and security',
                    items: [
                      SettingsItemData(icon: Icons.lock_outline_rounded, label: 'Password and security', onTap: () {}),
                      SettingsItemData(icon: Icons.headset_mic_outlined, label: 'Help and support', onTap: () {}),
                      SettingsItemData(icon: Icons.info_outline_rounded, label: 'About', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SettingsSection(
                    title: 'Login and deactivation',
                    items: [
                      SettingsItemData(icon: Icons.login_rounded, label: 'Login another account', onTap: () {}),
                      SettingsItemData(
                        icon: Icons.logout_rounded,
                        label: 'Log out',
                        isDestructive: true,
                        onTap: () {},
                      ),
                      SettingsItemData(
                        icon: Icons.delete_outline_rounded,
                        label: 'Deactivate and delete',
                        isDestructive: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
