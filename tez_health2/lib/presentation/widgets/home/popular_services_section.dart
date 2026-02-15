import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../models/popular_service_response.dart';
import '../../../theme/app_colors.dart';

class PopularServicesSection extends StatelessWidget {
  final List<PopularServiceData> popularServices;

  const PopularServicesSection({
    super.key,
    required this.popularServices,
  });

  @override
  Widget build(BuildContext context) {
    if (popularServices.isEmpty) {
      return const SizedBox.shrink();
    }

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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularServices.length,
            itemBuilder: (context, index) {
              return _ServiceCard(service: popularServices[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final PopularServiceData service;

  const _ServiceCard({required this.service});

  String _getPrice() {
    if (service.variants != null && service.variants!.isNotEmpty) {
      final variant = service.variants!.first;
      if (variant.discountPrice != null && variant.discountPrice! > 0) {
        return '₹ ${variant.discountPrice}';
      }
      if (variant.price != null) {
        return '₹ ${variant.price}';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = service.imageUrl ?? '';
    final isAssetImage = imageUrl.startsWith('assets/');
    final price = _getPrice();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.push('/product-details/${service.productId}');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image
              SizedBox(
                width: 120,
                height: 120,
                child: imageUrl.isEmpty
                    ? Container(
                        color: AppColors.gray100,
                        child: const Icon(Icons.medical_services, color: AppColors.gray400, size: 32),
                      )
                    : isAssetImage
                        ? Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
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
                        service.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (price.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          price,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.tezBlue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                      if (service.description != null && service.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          service.description!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
