import 'package:flutter/material.dart';
import '../../../models/category.dart';
import '../../../theme/app_colors.dart';
import '../common/category_card.dart';

class TopCategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final Function(Category category) onCategoryTap;

  const TopCategoriesSection({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayCategories = categories.take(6).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: isDark ? AppColors.gray900 : AppColors.gray50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Categories',

            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Explore our most popular healthcare services',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Categories Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: displayCategories.length,
            itemBuilder: (context, index) {
              final category = displayCategories[index];
              return CategoryCard(
                category: category,
                onTap: () => onCategoryTap(category),
              );
            },
          ),
        ],
      ),
    );
  }

}
