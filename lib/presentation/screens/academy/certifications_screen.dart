import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';

class CertificationsScreen extends StatelessWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Certifications',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildCertificationCard(context, index);
        },
      ),
    );
  }

  Widget _buildCertificationCard(BuildContext context, int index) {
    final certifications = [
      'Basic First Aid',
      'CPR Training',
      'Basic Life Support',
    ];

    final dates = [
      'Completed on Dec 15, 2024',
      'Completed on Nov 28, 2024',
      'Completed on Oct 10, 2024',
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              [
                AppTheme.alertRed,
                AppTheme.trustBlue,
                AppTheme.successGreen
              ][index % 3]
                  .withValues(alpha: 0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: [
                        AppTheme.alertRed,
                        AppTheme.trustBlue,
                        AppTheme.successGreen
                      ][index % 3]
                          .withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      color: [
                        AppTheme.alertRed,
                        AppTheme.trustBlue,
                        AppTheme.successGreen
                      ][index % 3],
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          certifications[index],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dates[index],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.mediumGrey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: AppTheme.successGreen,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.successGreen,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('View'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.trustBlue,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, size: 16),
                        label: const Text('Download'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.trustBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
