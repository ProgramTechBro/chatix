import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Urbanist';
  static const String fontFamilySecondary = 'RobotoFlex';

  static const TextStyle titleRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle titleTiny = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 1.0,
    color: AppColors.white,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.0,
    color: AppColors.white,
  );

  static const TextStyle paragraphMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle paragraphSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.textSecondary,
  );
}
