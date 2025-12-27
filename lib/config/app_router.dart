import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_bloc.dart';
import 'package:tez_health/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:tez_health/presentation/screens/splash/splash_screen.dart';
import 'package:tez_health/presentation/screens/emergency/emergency_screen.dart';
import 'package:tez_health/presentation/screens/emergency/ambulance_booking_screen.dart';
import 'package:tez_health/presentation/screens/emergency/track_ambulance_screen.dart';
import 'package:tez_health/presentation/screens/emergency/hospital_network_screen.dart';
import 'package:tez_health/presentation/screens/healthcare/healthcare_screen.dart';
import 'package:tez_health/presentation/screens/healthcare/doctor_booking_screen.dart';
import 'package:tez_health/presentation/screens/healthcare/diagnostics_screen.dart';
import 'package:tez_health/presentation/screens/healthcare/nursing_screen.dart';
import 'package:tez_health/presentation/screens/store/store_screen.dart';
import 'package:tez_health/presentation/screens/store/product_details_screen.dart';
import 'package:tez_health/presentation/screens/store/cart_screen.dart';
import 'package:tez_health/presentation/screens/academy/academy_screen.dart';
import 'package:tez_health/presentation/screens/academy/course_details_screen.dart';
import 'package:tez_health/presentation/screens/academy/certifications_screen.dart';
import 'package:tez_health/utils/constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
    routes: [
      // Splash Screen
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Dashboard
      GoRoute(
        path: RouteNames.dashboard,
        builder: (context, state) => BlocProvider(
          create: (context) => DashboardBloc(),
          child: const DashboardScreen(),
        ),
      ),

      // Emergency Module
      GoRoute(
        path: RouteNames.emergency,
        builder: (context, state) => const EmergencyScreen(),
      ),
      GoRoute(
        path: RouteNames.ambulanceBooking,
        builder: (context, state) => const AmbulanceBookingScreen(),
      ),
      GoRoute(
        path: RouteNames.trackAmbulance,
        builder: (context, state) {
          final bookingId = state.uri.queryParameters['bookingId'] ?? '';
          return TrackAmbulanceScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: RouteNames.hospitalNetwork,
        builder: (context, state) => const HospitalNetworkScreen(),
      ),

      // Healthcare Module
      GoRoute(
        path: RouteNames.healthcare,
        builder: (context, state) => const HealthcareScreen(),
      ),
      GoRoute(
        path: RouteNames.doctorBooking,
        builder: (context, state) => const DoctorBookingScreen(),
      ),
      GoRoute(
        path: RouteNames.diagnostics,
        builder: (context, state) => const DiagnosticsScreen(),
      ),
      GoRoute(
        path: RouteNames.nursing,
        builder: (context, state) => const NursingScreen(),
      ),

      // Store Module
      GoRoute(
        path: RouteNames.store,
        builder: (context, state) => const StoreScreen(),
      ),
      GoRoute(
        path: '/store/product/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id'] ?? '';
          return ProductDetailsScreen(productId: productId);
        },
      ),
      GoRoute(
        path: RouteNames.cart,
        builder: (context, state) => const CartScreen(),
      ),

      // Academy Module
      GoRoute(
        path: RouteNames.academy,
        builder: (context, state) => const AcademyScreen(),
      ),
      GoRoute(
        path: '/academy/course/:id',
        builder: (context, state) {
          final courseId = state.pathParameters['id'] ?? '';
          return CourseDetailsScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: RouteNames.certifications,
        builder: (context, state) => const CertificationsScreen(),
      ),
    ],
  );
}
