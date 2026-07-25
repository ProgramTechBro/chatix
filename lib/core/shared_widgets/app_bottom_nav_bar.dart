import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const List<_NavItemData> _items = [
    _NavItemData(
      label: 'Home',
      selectedIcon: AppIcons.navHomeSelected,
      unselectedIcon: AppIcons.navHomeUnselected,
    ),
    _NavItemData(
      label: 'Videos',
      selectedIcon: AppIcons.navVideosSelected,
      unselectedIcon: AppIcons.navVideosUnselected,
    ),
    _NavItemData(
      label: 'Profile',
      selectedIcon: AppIcons.navProfileSelected,
      unselectedIcon: AppIcons.navProfileUnselected,
    ),
    _NavItemData(
      label: 'Notifications',
      selectedIcon: AppIcons.navNotificationsSelected,
      unselectedIcon: AppIcons.navNotificationsUnselected,
    ),
    _NavItemData(
      label: 'Settings',
      selectedIcon: AppIcons.navSettingsSelected,
      unselectedIcon: AppIcons.navSettingsUnselected,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            return Expanded(
              child: _NavBarButton(
                data: item,
                isSelected: index == selectedIndex,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({required this.data, required this.isSelected, required this.onTap});

  final _NavItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? data.selectedIcon : data.unselectedIcon,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.label, required this.selectedIcon, required this.unselectedIcon});

  final String label;
  final String selectedIcon;
  final String unselectedIcon;
}
