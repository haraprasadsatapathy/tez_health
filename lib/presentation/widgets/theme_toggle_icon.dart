import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/presentation/cubit/theme/theme_bloc.dart';
import 'package:tez_health/presentation/cubit/theme/theme_event.dart';
import 'package:tez_health/presentation/cubit/theme/theme_state.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.themeMode == ThemeMode.dark;

        return IconButton(
          icon: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: isDarkMode ? Colors.amber : null,
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(const ToggleThemeEvent());
          },
          tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        );
      },
    );
  }
}
