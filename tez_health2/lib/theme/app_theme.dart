import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.tezBlue,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.tezBlue,
      secondary: AppColors.brand500,
      surface: AppColors.white,
      error: Colors.red,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.gray900,
      onError: AppColors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      // Title Sizes
      displayLarge: GoogleFonts.outfit(
        fontSize: 72,
        height: 90 / 72,
        fontWeight: FontWeight.bold,
        color: AppColors.gray900,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 60,
        height: 72 / 60,
        fontWeight: FontWeight.bold,
        color: AppColors.gray900,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 48,
        height: 60 / 48,
        fontWeight: FontWeight.bold,
        color: AppColors.gray900,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 30,
        height: 38 / 30,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        height: 30 / 20,
        fontWeight: FontWeight.w700,
        color: AppColors.gray900,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray900,
      ),
      titleSmall: GoogleFonts.outfit(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: AppColors.gray900,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray800,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      bodySmall: GoogleFonts.outfit(
        fontSize: 12,
        height: 18 / 12,
        fontWeight: FontWeight.w400,
        color: AppColors.gray500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.tezBlue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.tezBlue,
        side: const BorderSide(color: AppColors.tezBlue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.gray200),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      surfaceTintColor: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.gray900),
      titleTextStyle: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.tezBlue,
    scaffoldBackgroundColor: AppColors.gray950,
    colorScheme: ColorScheme.dark(
      primary: AppColors.tezBlue,
      secondary: AppColors.brand500,
      surface: AppColors.gray900,
      error: Colors.red,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.gray50,
      onError: AppColors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      // Title Sizes
      displayLarge: GoogleFonts.outfit(
        fontSize: 72,
        height: 90 / 72,
        fontWeight: FontWeight.bold,
        color: AppColors.gray50,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 60,
        height: 72 / 60,
        fontWeight: FontWeight.bold,
        color: AppColors.gray50,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 48,
        height: 60 / 48,
        fontWeight: FontWeight.bold,
        color: AppColors.gray50,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 30,
        height: 38 / 30,
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 20,
        height: 27 / 24,
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        height: 30 / 20,
        fontWeight: FontWeight.w700,
        color: AppColors.gray50,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray50,
      ),
      titleSmall: GoogleFonts.outfit(
        fontSize: 14,
        letterSpacing: 0,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: AppColors.gray50,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray200,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray400,
      ),
      bodySmall: GoogleFonts.outfit(
        fontSize: 12,
        height: 18 / 12,
        fontWeight: FontWeight.w400,
        color: AppColors.gray500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.tezBlue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.tezBlue,
        side: const BorderSide(color: AppColors.tezBlue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.gray900,
      surfaceTintColor: AppColors.gray900,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.gray800),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.gray900,
      elevation: 0,
      surfaceTintColor: AppColors.gray900,
      iconTheme: const IconThemeData(color: AppColors.gray50),
      titleTextStyle: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
    ),
  );
}
