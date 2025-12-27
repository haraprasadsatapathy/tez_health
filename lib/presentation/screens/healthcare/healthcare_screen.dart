import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/presentation/widgets/theme_toggle_icon.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class HealthcareScreen extends StatelessWidget {
  const HealthcareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tez Care',
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
                      AppTheme.trustBlue.withValues(alpha: 0.1),
                      AppTheme.trustBlue.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 48,
                      color: AppTheme.trustBlue,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home Healthcare',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quality healthcare at your doorstep',
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

              // Quick Actions Grid
              Text(
                'Services',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      title: 'Doctor Visit',
                      subtitle: 'At home or online',
                      icon: Icons.person,
                      color: AppTheme.trustBlue,
                      onTap: () => context.push(RouteNames.doctorBooking),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      title: 'Diagnostics',
                      subtitle: 'Lab tests at home',
                      icon: Icons.biotech,
                      color: AppTheme.successGreen,
                      onTap: () => context.push(RouteNames.diagnostics),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      title: 'Nursing',
                      subtitle: 'Certified nurses',
                      icon: Icons.health_and_safety,
                      color: AppTheme.warningOrange,
                      onTap: () => context.push(RouteNames.nursing),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      title: 'Telemedicine',
                      subtitle: 'Video consultation',
                      icon: Icons.video_call,
                      color: AppTheme.alertRed,
                      onTap: () => context.push(RouteNames.telemedicine),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Upcoming Appointments
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Appointments',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: View all appointments
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildAppointmentCard(
                context,
                doctorName: 'Dr. Sarah Johnson',
                specialization: 'General Physician',
                date: 'Tomorrow, 10:00 AM',
                type: 'Home Visit',
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.mediumGrey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context, {
    required String doctorName,
    required String specialization,
    required String date,
    required String type,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.trustBlue.withValues(alpha: 0.2),
              child: const Icon(
                Icons.person,
                size: 28,
                color: AppTheme.trustBlue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialization,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.mediumGrey,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppTheme.mediumGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.trustBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.trustBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
