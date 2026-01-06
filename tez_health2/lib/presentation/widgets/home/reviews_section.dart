import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../common/rating_stars.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Over 1000+ heartfelt Reviews',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),

          // Reviews Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: _getCrossAxisCount(context),
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: _reviews.map((review) {
              return _ReviewCard(review: review);
            }).toList(),
          ),

          const SizedBox(height: 24),
          Center(
            child: OutlinedButton(
              onPressed: () {
                // Open Google Reviews
              },
              child: const Text('Read more reviews on Google'),
            ),
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

  static final List<_ReviewData> _reviews = [
    _ReviewData(
      name: 'Radhika Freebird',
      avatar: AppConstants.radhikaAvatar,
      rating: 5.0,
      review:
          'Today I used their services (for the first time, they came up in Google Search) for giving injections at home. There was total clarity. They asked me to get the injection. Came within the stipulated time. Took 50% as booking amount, rest after service. Sister Suma did a quick and efficient job with single prick..usually it is difficult to find the vein for patient. They offered the service at a very reasonable price compared to others i contacted.',
    ),
    _ReviewData(
      name: 'Sunil Reddy',
      avatar: AppConstants.sunilAvatar,
      rating: 5.0,
      review:
          'I recently hired an ambulance and had a very positive experience. The driver, Prem, was extremely helpful, friendly, and kind throughout the journey. He made sure everything was handled smoothly and with care. His calm and professional attitude really helped during a stressful time. Highly recommend his service — thank you, Prem, for your excellent support!.',
    ),
    _ReviewData(
      name: 'Heena Shaman',
      avatar: AppConstants.heenaAvatar,
      rating: 5.0,
      review:
          'I recently used Vmedo\'s home-based vaccination services. The service was excellent — very professional and convenient. Suma visited regularly for each dose; she was punctual, gentle, and made the injections almost painless. Really appreciate her care and the overall smooth experience. Highly recommend Vmedo for home vaccination services.',
    ),
  ];
}

class _ReviewData {
  final String name;
  final String avatar;
  final double rating;
  final String review;

  _ReviewData({
    required this.name,
    required this.avatar,
    required this.rating,
    required this.review,
  });
}

class _ReviewCard extends StatelessWidget {
  final _ReviewData review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and Name
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(review.avatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      RatingStars(rating: review.rating),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Review Text
            Expanded(
              child: Text(
                review.review,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
