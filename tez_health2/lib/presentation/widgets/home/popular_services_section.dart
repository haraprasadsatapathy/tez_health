import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/app_constants.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Services',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Our most requested healthcare services',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Vertical Scrollable List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _popularServices.length,
            itemBuilder: (context, index) {
              return _ServiceCard(service: _popularServices[index]);
            },
          ),
        ],
      ),
    );
  }

  static final List<_ServiceData> _popularServices = [
    const _ServiceData(
      productId: 'PRD001',
      title: 'Injection service',
      price: '₹ 499',
      image:
          'https://images.unsplash.com/photo-1550831107-1553da8c8464?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      description: 'Essential health checks, blood tests & scans delivered at home.',
    ),
    const _ServiceData(
      productId: 'PRD002',
      title: 'Ecg at home',
      price: '₹ 799',
      image:
          'https://images.unsplash.com/photo-1599058917212-d750089bc07e?auto=format&fit=crop&w=800&q=80',
      description: 'Recover mobility with expert in-home physiotherapy sessions.',
    ),
    _ServiceData(
      productId: 'PRD003',
      title: 'Rabies vaccination',
      price: '₹ 499',
      image: AppConstants.vaccination,
      description: 'Nursing support for elderly, chronic patients, and recovery care.',
    ),
    _ServiceData(
      productId: 'PRD004',
      title: 'Doctor consultation online',
      price: '₹ 699',
      image: AppConstants.doctorConsultation,
      description: 'Skilled post-op nursing and wound care at home for smooth recovery.',
    ),
  ];
}

class _ServiceData {
  final String productId;
  final String title;
  final String price;
  final String image;
  final String description;

  const _ServiceData({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceData service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final isAssetImage = service.image.startsWith('assets/');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.push(
              '/service-details/${service.productId}?title=${Uri.encodeComponent(service.title)}&price=${Uri.encodeComponent(service.price)}&image=${Uri.encodeComponent(service.image)}&description=${Uri.encodeComponent(service.description)}',
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image
              SizedBox(
                width: 120,
                height: 120,
                child: isAssetImage
                    ? Image.asset(
                        service.image,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: service.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.gray100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.gray100,
                          child: const Icon(Icons.image, color: AppColors.gray400, size: 32),
                        ),
                      ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.price,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.tezBlue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
