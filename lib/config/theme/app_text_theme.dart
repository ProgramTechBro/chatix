import 'package:flutter/material.dart';
import '../app_typography.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme {
    return const TextTheme(
      titleLarge: AppTypography.titleRegular,
      titleMedium: AppTypography.titleSmall,
      labelSmall: AppTypography.titleTiny,
      labelLarge: AppTypography.button,
      labelMedium: AppTypography.buttonSmall,
      bodySmall: AppTypography.paragraphSmall,
    );
  }
}
