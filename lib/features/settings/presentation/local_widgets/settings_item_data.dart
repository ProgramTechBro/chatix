import 'package:flutter/material.dart';

class SettingsItemData {
  const SettingsItemData({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;
}
