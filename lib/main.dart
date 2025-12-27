import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/config/app_router.dart';
import 'package:tez_health/config/dependency_injection.dart';
import 'package:tez_health/presentation/cubit/theme/theme_bloc.dart';
import 'package:tez_health/presentation/cubit/theme/theme_state.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

void main() async {
  try {
    debugPrint('🚀 Starting Tez Health App...');
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('✅ Flutter binding initialized');

    // Setup dependency injection
    debugPrint('⚙️ Setting up dependency injection...');
    await setupDependencyInjection();
    debugPrint('✅ Dependency injection setup complete');

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    debugPrint('✅ Orientation preferences set');

    debugPrint('🎯 Launching app...');
    runApp(const TezHealthApp());
  } catch (e, stackTrace) {
    debugPrint('❌ Error during app initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    // Show error screen
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TezHealthApp extends StatelessWidget {
  const TezHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: const TezHealthAppView(),
    );
  }
}

class TezHealthAppView extends StatelessWidget {
  const TezHealthAppView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('📱 Building TezHealthAppView');
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        debugPrint('🎨 Theme state: ${state.themeMode}');
        debugPrint('🗺️ Initializing router with initial location: /');
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
