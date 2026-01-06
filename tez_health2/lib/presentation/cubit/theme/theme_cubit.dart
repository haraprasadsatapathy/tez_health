import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey) ?? false;
      emit(ThemeState(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        isDarkMode: isDark,
      ));
    } catch (e) {
      // If there's an error, default to light theme
      emit(const ThemeState());
    }
  }

  Future<void> toggleTheme() async {
    final newIsDark = !state.isDarkMode;
    emit(ThemeState(
      themeMode: newIsDark ? ThemeMode.dark : ThemeMode.light,
      isDarkMode: newIsDark,
    ));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newIsDark);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> setTheme(bool isDark) async {
    emit(ThemeState(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      isDarkMode: isDark,
    ));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDark);
    } catch (e) {
      // Handle error silently
    }
  }
}
