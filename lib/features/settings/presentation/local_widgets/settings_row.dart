import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import 'settings_item_data.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.data, required this.showDivider});

  final SettingsItemData data;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = data.isDestructive ? AppColors.danger : AppColors.primary;

    return InkWell(
      onTap: data.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: showDivider ? const Border(bottom: BorderSide(color: AppColors.divider)) : null,
        ),
        child: Row(
          children: [
            Icon(data.icon, size: 24, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(data.label, style: textTheme.labelMedium?.copyWith(color: AppColors.black)),
            ),
            const Icon(Icons.chevron_right_rounded, size: 24, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
