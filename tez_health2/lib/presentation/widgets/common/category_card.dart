import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/category.dart';
import '../../../theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Image
            Expanded(
              child: CachedNetworkImage(
                imageUrl: category.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.gray100,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.gray100,
                  child: const Icon(Icons.category, color: AppColors.gray400),
                ),
              ),
            ),

            // Category Info
            Padding(
              padding: const EdgeInsets.all(8), // Reduced from 5 to 8 for better overall spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Added: minimizes vertical space
                children: [
                  Text(
                    category.name,
                    textAlign: TextAlign.center, // Changed from center to start for consistency
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 0), // Added: controls exact gap between texts
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/lightning.png',
                        width: 16, // Reduced from 30 to make it more proportional
                        height: 16, // Reduced from 30 to make it more proportional
                      ),
                      const SizedBox(width: 4), // Added: small gap between icon and text
                      Expanded( // Added: prevents overflow
                        child: Text(
                          category.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
