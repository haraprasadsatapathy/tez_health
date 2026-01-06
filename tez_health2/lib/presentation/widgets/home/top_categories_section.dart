import 'package:flutter/material.dart';
import '../../../models/category.dart';
import '../../../theme/app_colors.dart';
import '../common/category_card.dart';

class TopCategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final Function(String categoryId) onCategoryTap;

  const TopCategoriesSection({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    // Limit to 5 categories on home screen
    final displayCategories = categories.take(5).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      color: isDark ? AppColors.gray900 : AppColors.gray50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Categories',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Explore our most popular healthcare services',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),

          // Categories Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: displayCategories.length,
            itemBuilder: (context, index) {
              final category = displayCategories[index];
              return CategoryCard(
                category: category,
                onTap: () => onCategoryTap(category.categoryId),
              );
            },
          ),

          // View All Button
          if (categories.length > 5) ...[
            const SizedBox(height: 24),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to all categories
                },
                child: const Text('View All Categories'),
              ),
            ),
          ],
        ],
      ),
    );
  }

}
