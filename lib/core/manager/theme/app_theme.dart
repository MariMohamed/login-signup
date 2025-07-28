import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';

class AppTheme {
  static ThemeData _standardTheme({required bool isDark}) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorSchemeSeed: AppColors.main,
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme = _standardTheme(isDark: true);
  static ThemeData lightTheme = _standardTheme(isDark: false);
}
