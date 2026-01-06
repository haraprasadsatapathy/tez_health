import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class WhyTezHealthSection extends StatelessWidget {
  const WhyTezHealthSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      color: isDark ? AppColors.gray900 : AppColors.brand50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why families trust Tez Health?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Faster, safer and more reliable healthcare — right at your doorstep.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Benefits Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: _getCrossAxisCount(context),
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: const [
              _BenefitCard(
                icon: Icons.verified_user,
                title: 'Certified and Experienced Professionals',
                description:
                    'Our in-house professionals with a minimum of 5 years of clinical experience deliver hospital-grade care at home with precision, compassion, and accountability.',
              ),
              _BenefitCard(
                icon: Icons.support_agent,
                title: '24×7 Customer Support',
                description:
                    'Our round-the-clock support team is always available to guide, assist, and resolve your concerns instantly.',
              ),
              _BenefitCard(
                icon: Icons.attach_money,
                title: 'Transparent & Honest Pricing',
                description:
                    'We believe families deserve clarity, not surprises. Every service comes with clear, upfront pricing and zero hidden charges.',
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: _getStatsCrossAxisCount(context),
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: const [
              _StatCard(
                number: '20,000+',
                description: 'patients served in last one year',
              ),
              _StatCard(
                number: '30 Min',
                description: 'Avg time for care arrival at home',
              ),
              _StatCard(
                number: '4.8⭐',
                description: 'Avg google rating form 1000+ reviews',
              ),
              _StatCard(
                number: '65%',
                description: 'reduction in hospital visits with Tez Health Services',
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return 3;
    if (width >= 768) return 2;
    return 1;
  }

  int _getStatsCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return 4;
    if (width >= 768) return 2;
    return 2;
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: AppColors.tezBlue),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String description;

  const _StatCard({
    required this.number,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.tezBlue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
