import 'package:flutter/material.dart';
import 'package:tez_health/presentation/cubit/base/base_event_state.dart';

abstract class ThemeEvent extends BaseEventState {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}

class SetThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const SetThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}
