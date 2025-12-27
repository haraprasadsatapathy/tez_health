import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/presentation/widgets/theme_toggle_icon.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tez Rescue',
        actions: [
          ThemeToggleIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.alertRed.withValues(alpha: 0.1),
                      AppTheme.alertRed.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.emergency,
                      size: 48,
                      color: AppTheme.alertRed,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Services',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Fast response when you need it most',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.mediumGrey,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Ambulance Services
              Text(
                'Ambulance Services',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _buildAmbulanceCard(
                context,
                title: 'BLS Ambulance',
                subtitle: 'Basic Life Support',
                icon: Icons.local_hospital,
                type: AppConstants.ambulanceBLS,
              ),
              const SizedBox(height: 12),
              _buildAmbulanceCard(
                context,
                title: 'ALS Ambulance (ICU)',
                subtitle: 'Advanced Life Support',
                icon: Icons.emergency_outlined,
                type: AppConstants.ambulanceALS,
              ),
              const SizedBox(height: 12),
              _buildAmbulanceCard(
                context,
                title: 'Mortuary Van',
                subtitle: 'Body transportation',
                icon: Icons.directions_car,
                type: AppConstants.ambulanceMortuary,
              ),
              const SizedBox(height: 24),

              // Hospital Network
              Text(
                'Hospital Network',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                child: InkWell(
                  onTap: () {
                    context.push(RouteNames.hospitalNetwork);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.trustBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_hospital,
                            size: 32,
                            color: AppTheme.trustBlue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nearby Hospitals',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Find hospitals with bed availability',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.mediumGrey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.mediumGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmbulanceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required String type,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          context.push(RouteNames.ambulanceBooking);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.alertRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: AppTheme.alertRed,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.alertRed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
