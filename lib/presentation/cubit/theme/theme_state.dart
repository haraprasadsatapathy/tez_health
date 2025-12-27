import 'package:flutter/material.dart';
import 'package:tez_health/presentation/cubit/base/base_event_state.dart';

class ThemeState extends BaseEventState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themeMode];
}
