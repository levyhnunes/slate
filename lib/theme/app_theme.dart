import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF000000);
  static const background = Color(0xFFF4F2F1);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF0B0B0B);
  static const textSecondary = Color(0xFF9A9A9A);
  static const hint = Color(0xFFBDBDBD);
  static const divider = Color(0xFFE2E0DF);
  static const hairline = Color(0xFFEFEFEF);
  static const positive = Color(0xFF2FB174);
}

class AppTheme {
  static const fontFamily = 'PlusJakartaSans';

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.black,
        primary: AppColors.black,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: fontFamily,
    );

    OutlineInputBorder border(BorderSide side) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: side,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 16.5,
        ),
        hintStyle: const TextStyle(color: AppColors.hint, letterSpacing: -0.3),
        border: border(BorderSide.none),
        enabledBorder: border(BorderSide.none),
        focusedBorder: border(
          const BorderSide(color: AppColors.black, width: 1.5),
        ),
      ),
    );
  }
}
