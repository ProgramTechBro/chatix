import 'package:flutter/material.dart';
import '../../../../../config/app_colors.dart';
import 'settings_item_data.dart';
import 'settings_row.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.title, required this.items});

  final String title;
  final List<SettingsItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: AppColors.surface,
            child: Column(
              children: [
                for (var i = 0; i < items.length; i++)
                  SettingsRow(
                    data: items[i],
                    showDivider: i != items.length - 1,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
