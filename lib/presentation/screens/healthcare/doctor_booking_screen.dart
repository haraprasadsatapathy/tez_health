import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';

class DoctorBookingScreen extends StatelessWidget {
  const DoctorBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Book Doctor',
      ),
      body: Column(
        children: [
          // Search & Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search doctors, specializations...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppTheme.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      _buildFilterChip('General'),
                      _buildFilterChip('Pediatrics'),
                      _buildFilterChip('Cardiology'),
                      _buildFilterChip('Dermatology'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Doctors List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildDoctorCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: label == 'All',
        onSelected: (selected) {},
        selectedColor: AppTheme.trustBlue.withValues(alpha: 0.2),
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Show doctor details and booking
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
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
                      'Dr. ${index % 2 == 0 ? "Sarah" : "John"} ${["Smith", "Johnson", "Williams", "Brown"][index % 4]}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ['General Physician', 'Pediatrician', 'Cardiologist', 'Dermatologist'][index % 4],
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
                          '4.${9 - (index % 5)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.work_outline,
                          size: 14,
                          color: AppTheme.mediumGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${5 + index} years exp.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.mediumGrey,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Book'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${500 + (index * 100)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
