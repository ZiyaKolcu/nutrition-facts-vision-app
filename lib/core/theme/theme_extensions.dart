import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textStyles => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension AppColorsExtension on BuildContext {
  Color get primaryColor =>
      isDarkMode ? AppColors.primaryDark : AppColors.primary;
  Color get backgroundColor =>
      isDarkMode ? AppColors.backgroundDark : AppColors.background;
  Color get surfaceColor =>
      isDarkMode ? AppColors.surfaceDark : AppColors.surface;
  Color get textPrimaryColor =>
      isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
  Color get textSecondaryColor =>
      isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
  Color get outlineColor =>
      isDarkMode ? AppColors.outlineDark : AppColors.outline;
}

extension AppTextStylesExtension on BuildContext {
  TextStyle get h1 => AppTextStyles.h1.copyWith(color: textPrimaryColor);

  TextStyle get h2 => AppTextStyles.h2.copyWith(color: textPrimaryColor);

  TextStyle get h3 => AppTextStyles.h3.copyWith(color: textPrimaryColor);

  TextStyle get h4 => AppTextStyles.h4.copyWith(color: textPrimaryColor);

  TextStyle get subtitle1 =>
      AppTextStyles.subtitle1.copyWith(color: textPrimaryColor);

  TextStyle get subtitle2 =>
      AppTextStyles.subtitle2.copyWith(color: textSecondaryColor);

  TextStyle get body1 => AppTextStyles.body1.copyWith(color: textPrimaryColor);

  TextStyle get body2 => AppTextStyles.body2.copyWith(color: textPrimaryColor);

  TextStyle get caption =>
      AppTextStyles.caption.copyWith(color: textSecondaryColor);
}
