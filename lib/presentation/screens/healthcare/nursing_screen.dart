import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';

class NursingScreen extends StatelessWidget {
  const NursingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Nursing Services',
      ),
      body: Column(
        children: [
          // Service Type Selection
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildServiceTypeCard(
                    context,
                    'Hourly',
                    '₹200/hr',
                    Icons.access_time,
                    true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildServiceTypeCard(
                    context,
                    'Daily',
                    '₹1500/day',
                    Icons.calendar_today,
                    false,
                  ),
                ),
              ],
            ),
          ),

          // Nurses List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildNurseCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTypeCard(
    BuildContext context,
    String title,
    String price,
    IconData icon,
    bool isSelected,
  ) {
    return Card(
      color: isSelected ? AppTheme.trustBlue : null,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.trustBlue,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? Colors.white : null,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white : AppTheme.mediumGrey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNurseCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Show nurse details and booking
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppTheme.successGreen.withValues(alpha: 0.2),
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: AppTheme.successGreen,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nurse ${["Mary", "Anna", "Lisa", "Emma", "Sophia", "Olivia"][index]}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${5 + index} years experience',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.mediumGrey,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: AppTheme.warningOrange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.${9 - (index % 3)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.successGreen.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Available',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.successGreen,
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
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildSkillChip('Post-op Care'),
                        _buildSkillChip('Elderly Care'),
                        _buildSkillChip('IV Administration'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.trustBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppTheme.trustBlue,
        ),
      ),
    );
  }
}
