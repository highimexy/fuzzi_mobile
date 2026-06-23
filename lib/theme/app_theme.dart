import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF1a202c);
  static const Color foreground = Color(0xFFe2e8f0);
  static const Color primary = Color(0xFF89937e);
  static const Color secondary = Color(0xFF576966);
  static const Color accent = Color(0xFFfde047);
  static const Color error = Color(0xFFef4444);
  static const Color correct = Color(0xFF34d399);
  static const Color wrong = Color(0xFFf87171);
  static const Color roughCard = Color(0xFF252d3b);
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final interTextTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        error: AppColors.error,
        surface: AppColors.background,
        onPrimary: AppColors.foreground,
        onSecondary: AppColors.foreground,
        onTertiary: AppColors.background,
        onError: AppColors.foreground,
        onSurface: AppColors.foreground,
      ),
      textTheme: interTextTheme.copyWith(
        displayLarge: GoogleFonts.getFont('Young Serif',
          fontSize: 40, fontWeight: FontWeight.w700, color: AppColors.foreground),
        headlineMedium: GoogleFonts.getFont('Young Serif',
          fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.foreground),
        headlineSmall: GoogleFonts.getFont('Young Serif',
          fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.foreground),
        titleLarge: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.foreground),
        titleMedium: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.foreground),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.foreground),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.foreground),
        bodySmall: GoogleFonts.inter(
          fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.foreground),
        labelLarge: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.foreground),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.roughCard,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.getFont('Young Serif',
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.foreground),
      ),
      cardColor: AppColors.roughCard,
      dividerColor: AppColors.secondary.withValues(alpha: 0.3),
      tabBarTheme: const TabBarThemeData(
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.secondary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.roughCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.roughCard,
        contentTextStyle: TextStyle(color: AppColors.foreground),
      ),
    );
  }
}
