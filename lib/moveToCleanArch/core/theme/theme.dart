import 'package:flutter/material.dart';
import 'package:start_journey/moveToCleanArch/core/theme/app_colors.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AppColors.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
    ),
  );
}
