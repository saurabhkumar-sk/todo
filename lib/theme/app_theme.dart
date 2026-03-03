import 'package:flutter/material.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';

class AppTheme {

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.purple,          // Use purple as main color
      onPrimary: AppColors.white,         // Text/icons on primary
      secondary: AppColors.lightGreen,    // Secondary color
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.primary,       // Text/icons on surface (black)
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.lightGreen,      // Use lightGreen as accent
      onPrimary: AppColors.white,    // Text/icons on primary background
      secondary: AppColors.purple,
      onSecondary: AppColors.lightBlack,
      error: AppColors.red,
      onError: AppColors.lightBlack,      // Text/icons on error bg
      surface: AppColors.black54,
      onSurface: AppColors.white,          // Text/icons on surface
    ),
  );
}