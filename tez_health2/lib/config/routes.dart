import 'package:go_router/go_router.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/main_navigation/main_navigation_screen.dart';
import '../presentation/screens/product/product_details_screen.dart';
import '../presentation/screens/product/category_products_screen.dart';
import '../presentation/screens/product/book_now_screen.dart';
import '../presentation/screens/service/service_details_screen.dart';
import '../presentation/screens/service/service_book_now_screen.dart';

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
    GoRoute(
      path: '/book-now/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return BookNowScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/service-details/:serviceId',
      builder: (context, state) {
        final serviceId = state.pathParameters['serviceId']!;
        final title = state.uri.queryParameters['title'] ?? 'Service';
        final price = state.uri.queryParameters['price'] ?? '';
        final image = state.uri.queryParameters['image'] ?? '';
        final description = state.uri.queryParameters['description'] ?? '';
        return ServiceDetailsScreen(
          serviceId: serviceId,
          title: title,
          price: price,
          image: image,
          description: description,
        );
      },
    ),
    GoRoute(
      path: '/book-now-service/:serviceId',
      builder: (context, state) {
        final serviceId = state.pathParameters['serviceId']!;
        final title = state.uri.queryParameters['title'] ?? 'Service';
        final price = state.uri.queryParameters['price'] ?? '';
        final image = state.uri.queryParameters['image'] ?? '';
        final description = state.uri.queryParameters['description'] ?? '';
        return ServiceBookNowScreen(
          serviceId: serviceId,
          title: title,
          price: price,
          image: image,
          description: description,
        );
      },
    ),
  ],
);
