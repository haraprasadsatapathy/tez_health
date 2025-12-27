import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/services/storage_service.dart';
import 'package:tez_health/utils/constants.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
          themeMode: _getInitialThemeMode(),
        )) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  static ThemeMode _getInitialThemeMode() {
    final themeModeString = StorageService.getString(AppConstants.keyThemeMode);
    if (themeModeString == 'dark') {
      return ThemeMode.dark;
    } else if (themeModeString == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(state.copyWith(themeMode: newThemeMode));
    await _saveThemeMode(newThemeMode);
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await _saveThemeMode(event.themeMode);
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    String themeModeString;
    if (themeMode == ThemeMode.dark) {
      themeModeString = 'dark';
    } else if (themeMode == ThemeMode.light) {
      themeModeString = 'light';
    } else {
      themeModeString = 'system';
    }
    await StorageService.setString(AppConstants.keyThemeMode, themeModeString);
  }
}
