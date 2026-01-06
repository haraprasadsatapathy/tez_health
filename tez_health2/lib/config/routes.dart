import 'package:go_router/go_router.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/main_navigation/main_navigation_screen.dart';
import '../presentation/screens/product/product_details_screen.dart';
import '../presentation/screens/product/category_products_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/product-details/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return ProductDetailsScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/products/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        final categoryName = state.uri.queryParameters['name'] ?? 'Products';
        return CategoryProductsScreen(
          categoryId: categoryId,
          categoryName: categoryName,
        );
      },
    ),
  ],
);
