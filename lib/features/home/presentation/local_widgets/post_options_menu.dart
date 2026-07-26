import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

Future<void> showPostOptionsMenu(BuildContext context, Offset tapPosition) {
  final screenSize = MediaQuery.of(context).size;
  const menuWidth = 200.0;
  final left = (tapPosition.dx - menuWidth + 24).clamp(12.0, screenSize.width - menuWidth - 12.0);
  final top = tapPosition.dy + 12;

  return showGeneralDialog(
    context: context,
    barrierLabel: 'Post options',
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          Positioned(
            left: left,
            top: top,
            width: menuWidth,
            child: const _PostOptionsCard(),
          ),
        ],
      );
    },
  );
}

class _PostOptionsCard extends StatelessWidget {
  const _PostOptionsCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _OptionRow(
              icon: Icons.thumb_up_alt_outlined,
              label: 'Interested',
              onTap: () => _selectOption(context, 'Marked as interested'),
            ),
            _OptionRow(
              icon: Icons.thumb_down_alt_outlined,
              label: 'Not Interested',
              onTap: () => _selectOption(context, 'Marked as not interested'),
            ),
            _OptionRow(
              icon: Icons.error_outline,
              label: 'Report',
              onTap: () => _selectOption(context, 'Reported. Thanks for letting us know.'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectOption(BuildContext context, String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.black),
            const SizedBox(width: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
