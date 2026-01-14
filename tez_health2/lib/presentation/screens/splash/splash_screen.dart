import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scooterAnimation;

  // Tez Blue color
  static const Color tezBlue = Color(0xFF3392E0);

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for scooter
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Scooter movement animation from -40 to 250
    _scooterAnimation = Tween<double>(
      begin: -40.0,
      end: 250.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // Repeat animation infinitely
    _animationController.repeat();

    // Navigate to home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tezBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo and Animation Section (Centered vertically)
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    AppConstants.logoWhite,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),

                  // Tagline
                  const Text(
                    'Healthcare in minutes !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Scooter Animation Container
                  SizedBox(
                    width: 256,
                    height: 40,
                    child: Stack(
                      children: [
                        // White line at the bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),

                        // Animated Scooter
                        AnimatedBuilder(
                          animation: _scooterAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_scooterAnimation.value, 0),
                              child: Image.asset(
                                AppConstants.motorcycle,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Statistics Section
            Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Left Stat: Customers Served
                      Column(
                        children: [
                          const Text(
                            '20,000+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Customers served',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Vertical Divider
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        height: 40,
                        width: 1,
                        color: Colors.white,
                      ),

                      // Right Stat: Google Ratings
                      Column(
                        children: [
                          const Text(
                            '4.8 ⭐',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Google Ratings',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Copyright Text
                  Text(
                    AppConstants.copyright,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
