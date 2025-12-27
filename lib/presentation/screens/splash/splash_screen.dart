import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    debugPrint('🎬 SplashScreen: initState called');
    _initAnimations();
    _startAnimations();
    _navigateToDashboard();
  }

  void _initAnimations() {
    // Scale animation for logo
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Fade animation for text
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide animation for tagline
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Pulse animation for loading indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
  }

  Future<void> _navigateToDashboard() async {
    debugPrint('⏱️ SplashScreen: Waiting 3 seconds before navigation...');
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) {
      debugPrint('⚠️ SplashScreen: Widget not mounted, skipping navigation');
      return;
    }

    try {
      debugPrint('🧭 SplashScreen: Navigating to dashboard...');
      context.go(RouteNames.dashboard);
      debugPrint('✅ SplashScreen: Navigation successful');
    } catch (e) {
      debugPrint('❌ Navigation error: $e');
      // Retry navigation after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        debugPrint('🔄 SplashScreen: Retrying navigation...');
        context.go(RouteNames.dashboard);
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🎬 SplashScreen: build called');
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    AppTheme.darkGrey,
                    AppTheme.black,
                  ]
                : [
                    AppTheme.white,
                    AppTheme.lightGrey,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              // Animated Logo
              ScaleTransition(
                scale: _scaleAnimation,
                child: Hero(
                  tag: 'app_logo',
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.trustBlue,
                          AppTheme.alertRed.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.trustBlue.withValues(alpha: 0.4),
                          blurRadius: 40,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/app_icon.jpeg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Animated App Name
              FadeTransition(
                opacity: _fadeAnimation,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppTheme.alertRed,
                      AppTheme.trustBlue,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Animated Tagline
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      AppConstants.appTagline,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDarkMode
                                ? AppTheme.mediumGrey
                                : AppTheme.mediumGrey,
                            letterSpacing: 0.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Animated Loading Indicator
              ScaleTransition(
                scale: _pulseAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? AppTheme.trustBlue : AppTheme.alertRed,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.mediumGrey,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Version Info
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.mediumGrey,
                      ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
