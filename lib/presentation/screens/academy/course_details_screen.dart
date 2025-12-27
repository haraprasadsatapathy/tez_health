import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course Details',
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Header
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.alertRed.withValues(alpha: 0.7),
                    AppTheme.alertRed.withValues(alpha: 0.3),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Basic First Aid',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: AppTheme.warningOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.8 (2,340 reviews)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Course Stats
                  Row(
                    children: [
                      _buildStatChip(Icons.access_time, '2 hours'),
                      const SizedBox(width: 12),
                      _buildStatChip(Icons.video_library, '8 lessons'),
                      const SizedBox(width: 12),
                      _buildStatChip(Icons.people, '12,450 enrolled'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'About this Course',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn essential first aid skills that can save lives. This comprehensive course covers basic wound care, CPR basics, choking response, and emergency response protocols.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.mediumGrey,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // What You'll Learn
                  Text(
                    'What You\'ll Learn',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  _buildLearningPoint('Basic wound care and bandaging'),
                  _buildLearningPoint('CPR fundamentals'),
                  _buildLearningPoint('Choking response techniques'),
                  _buildLearningPoint('Emergency assessment'),
                  _buildLearningPoint('Burn and fracture management'),
                  const SizedBox(height: 24),

                  // Course Content
                  Text(
                    'Course Content',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return _buildLessonTile(
                        context,
                        'Lesson ${index + 1}: ${[
                          "Introduction to First Aid",
                          "Wound Care Basics",
                          "CPR Fundamentals",
                          "Choking Response",
                          "Burn Treatment",
                          "Fracture Management",
                          "Emergency Assessment",
                          "Final Assessment"
                        ][index]}',
                        '${5 + (index * 2)} min',
                        index < 2, // First 2 lessons unlocked
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Enroll Now - Free',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.mediumGrey),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.mediumGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 18,
            color: AppTheme.successGreen,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTile(
    BuildContext context,
    String title,
    String duration,
    bool isUnlocked,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isUnlocked
              ? AppTheme.trustBlue.withValues(alpha: 0.1)
              : AppTheme.mediumGrey.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isUnlocked ? Icons.play_arrow : Icons.lock,
          color: isUnlocked ? AppTheme.trustBlue : AppTheme.mediumGrey,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: isUnlocked ? Colors.black : AppTheme.mediumGrey,
        ),
      ),
      trailing: Text(
        duration,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.mediumGrey,
        ),
      ),
      onTap: isUnlocked ? () {} : null,
    );
  }
}
