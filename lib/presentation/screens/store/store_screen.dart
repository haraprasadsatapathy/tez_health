import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/presentation/widgets/theme_toggle_icon.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tez Mart',
        actions: [
          const ThemeToggleIcon(),
          IconButton(
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              context.push(RouteNames.cart);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search medical equipment...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppTheme.lightGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryCard(
                      context,
                      'Mobility',
                      Icons.accessible,
                      AppTheme.trustBlue,
                    ),
                    _buildCategoryCard(
                      context,
                      'Respiratory',
                      Icons.air,
                      AppTheme.successGreen,
                    ),
                    _buildCategoryCard(
                      context,
                      'First Aid',
                      Icons.medical_services,
                      AppTheme.alertRed,
                    ),
                    _buildCategoryCard(
                      context,
                      'Monitoring',
                      Icons.monitor_heart,
                      AppTheme.warningOrange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Popular Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildProductCard(context, index);
                },
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    final products = [
      'Wheelchair',
      'Oxygen Concentrator',
      'Blood Pressure Monitor',
      'Thermometer',
      'Pulse Oximeter',
      'Walking Stick',
    ];

    final prices = [5000, 15000, 2500, 500, 1500, 800];
    final rentAvailable = [true, true, false, false, false, true];

    return Card(
      child: InkWell(
        onTap: () {
          context.push('/store/product/${index + 1}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Placeholder
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.trustBlue.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.medical_services,
                  size: 48,
                  color: AppTheme.trustBlue.withValues(alpha: 0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[index],
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${prices[index]}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.trustBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (rentAvailable[index]) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Rent Available',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.successGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
