import 'package:flutter/material.dart';
import '../../../models/category.dart';
import '../../../theme/app_colors.dart';
import '../common/category_card.dart';

class TopCategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final Function(Category category) onCategoryTap;
  final Function() onViewMoreTap;

  const TopCategoriesSection({
    super.key,
    required this.categories,
    required this.onCategoryTap,
    required this.onViewMoreTap,
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
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: OutlinedButton(
                    onPressed: () => onViewMoreTap(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      minimumSize: const Size(0, 32), // Reduced height
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'View More',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

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