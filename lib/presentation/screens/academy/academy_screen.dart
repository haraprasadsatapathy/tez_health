import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/presentation/widgets/theme_toggle_icon.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tez Academy',
        actions: [
          const ThemeToggleIcon(),
          IconButton(
            icon: const Icon(Icons.card_membership),
            onPressed: () {
              context.push(RouteNames.certifications);
            },
          ),
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
                      AppTheme.warningOrange.withValues(alpha: 0.1),
                      AppTheme.warningOrange.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      size: 48,
                      color: AppTheme.warningOrange,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skill Development',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Learn life-saving skills',
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

              // Categories
              Text(
                'Course Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All', true),
                    _buildCategoryChip('First Aid', false),
                    _buildCategoryChip('CPR', false),
                    _buildCategoryChip('Basic Life Support', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Featured Courses
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Courses',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildCourseCard(context, index);
                },
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {},
        selectedColor: AppTheme.warningOrange.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.warningOrange : AppTheme.mediumGrey,
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, int index) {
    final courses = [
      'Basic First Aid',
      'CPR Training',
      'Basic Life Support (BLS)',
      'Advanced Cardiac Life Support',
      'Pediatric First Aid',
    ];

    final durations = ['2 hours', '3 hours', '4 hours', '6 hours', '2 hours'];
    final lessons = [8, 12, 15, 20, 10];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          context.push('/academy/course/${index + 1}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Course Thumbnail
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    [
                      AppTheme.alertRed,
                      AppTheme.trustBlue,
                      AppTheme.successGreen,
                      AppTheme.warningOrange,
                      AppTheme.alertRed
                    ][index % 5]
                        .withValues(alpha: 0.7),
                    [
                      AppTheme.alertRed,
                      AppTheme.trustBlue,
                      AppTheme.successGreen,
                      AppTheme.warningOrange,
                      AppTheme.alertRed
                    ][index % 5]
                        .withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courses[index],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppTheme.mediumGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        durations[index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.mediumGrey,
                            ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.video_library,
                        size: 16,
                        color: AppTheme.mediumGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${lessons[index]} lessons',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.mediumGrey,
                            ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.successGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Free',
                          style: TextStyle(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
