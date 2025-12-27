import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';

class TrackAmbulanceScreen extends StatelessWidget {
  final String bookingId;

  const TrackAmbulanceScreen({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Track Ambulance',
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // TODO: Call driver
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Container (Placeholder)
          Expanded(
            child: Container(
              color: AppTheme.lightGrey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: AppTheme.mediumGrey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Map View',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Google Maps integration coming soon',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Driver Info Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ETA
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.alertRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppTheme.alertRed,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Arriving in 8 minutes',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.alertRed,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Driver Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppTheme.trustBlue.withValues(alpha: 0.2),
                      child: const Icon(
                        Icons.person,
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
                            'Driver Name',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: AppTheme.warningOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.8 • Vehicle: ABC-1234',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.mediumGrey,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Call driver
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: AppTheme.trustBlue,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.trustBlue.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Status
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppTheme.successGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'On the way',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
