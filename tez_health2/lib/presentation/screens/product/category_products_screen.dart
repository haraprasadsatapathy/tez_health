import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../config/dependency_injection.dart';
import '../../../domain/repository/tez_repository.dart';
import '../../cubit/product/product_bloc.dart';
import '../../cubit/product/product_event.dart';
import '../../cubit/product/product_state.dart';
import '../../widgets/common/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    this.categoryName = 'Products',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(getIt<TezRepository>())
        ..add(FetchProductsByCategoryEvent(categoryId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return const Center(
                  child: Text('No products found in this category'),
                );
              }

              final screenWidth = MediaQuery.of(context).size.width;
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  childAspectRatio: _getChildAspectRatio(screenWidth),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      context.push('/product-details/${product.productId}');
                    },
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(FetchProductsByCategoryEvent(categoryId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return 3;
    if (width >= 768) return 2;
    return 2; // Changed from 1 to 2 for better mobile layout
  }

  double _getChildAspectRatio(double screenWidth) {
    // Calculate card dimensions to minimize white space
    final crossAxisCount = screenWidth >= 1024 ? 3 : (screenWidth >= 768 ? 2 : 2);
    final padding = 12.0 * 2; // left and right padding
    final spacing = 10.0 * (crossAxisCount - 1); // spacing between cards
    final cardWidth = (screenWidth - padding - spacing) / crossAxisCount;

    // Calculate card height
    final imageHeight = cardWidth * 0.75; // Image takes 75% of width
    final contentHeight = 90.0; // Approximate fixed height for text content
    final cardHeight = imageHeight + contentHeight;

    // Return aspect ratio (width / height)
    return cardWidth / cardHeight;
  }
}
