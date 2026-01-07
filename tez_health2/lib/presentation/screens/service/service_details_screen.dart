import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceId;
  final String title;
  final String price;
  final String image;
  final String description;

  const ServiceDetailsScreen({
    super.key,
    required this.serviceId,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isAssetImage = image.startsWith('assets/');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: isAssetImage
                        ? Image.asset(
                            image,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.gray100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.gray100,
                              child: const Icon(Icons.image, size: 50),
                            ),
                          ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Title
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),

                        // Price
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.brand50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            price,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.tezBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Description Section
                        Text(
                          'About this Service',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                height: 1.6,
                              ),
                        ),
                        const SizedBox(height: 24),

                        // Features Section
                        Text(
                          'What\'s Included',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          context,
                          Icons.verified_user,
                          'Certified healthcare professionals',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.schedule,
                          'Flexible scheduling options',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.home,
                          'Service at your doorstep',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.support_agent,
                          '24/7 customer support',
                        ),
                        const SizedBox(height: 24),

                        // How it Works
                        Text(
                          'How it Works',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        _buildStepItem(context, '1', 'Book the service'),
                        _buildStepItem(context, '2', 'Our expert will contact you'),
                        _buildStepItem(context, '3', 'Get the service at your home'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Book Now Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to book now screen with service details
                  context.push(
                    '/book-now-service/$serviceId?title=${Uri.encodeComponent(title)}&price=${Uri.encodeComponent(price)}&image=${Uri.encodeComponent(image)}&description=${Uri.encodeComponent(description)}',
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.tezBlue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.tezBlue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
