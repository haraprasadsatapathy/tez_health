import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../config/dependency_injection.dart';
import '../../../domain/repository/tez_repository.dart';
import '../../cubit/home/home_bloc.dart';
import '../../cubit/home/home_event.dart';
import '../../cubit/home/home_state.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../../cubit/theme/theme_state.dart';
import '../../widgets/home/hero_carousel.dart';
import '../../widgets/home/top_categories_section.dart';
import '../../widgets/home/popular_services_section.dart';
import '../../widgets/home/why_tez_health_section.dart';
import '../../widgets/home/reviews_section.dart';
import '../../widgets/common/menu_drawer.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(getIt<TezRepository>())..add(const FetchCategoriesEvent()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Image.asset(AppConstants.logoBlue, height: 36)]),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(
                  themeState.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: themeState.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
              );
            },
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Carousel
            const HeroCarousel(),

            // Top Categories Section
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is CategoriesLoaded) {
                  return TopCategoriesSection(
                    categories: state.categories,
                    onCategoryTap: (category) {
                      context.push(
                        '/products/${category.categoryId}?name=${Uri.encodeComponent(category.name)}',
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Text(
                            'Failed to load categories',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(
                                const FetchCategoriesEvent(),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Popular Services
            const PopularServicesSection(),

            // Why Tez Health
            // const WhyTezHealthSection(),

            // Reviews
            // const ReviewsSection(),

            // Footer
            // Container(
            //   padding: const EdgeInsets.all(24),
            //   color: AppColors.gray900,
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [Image.asset(AppConstants.logoWhite, height: 36)],
            //       ),
            //       const SizedBox(height: 16),
            //       Text(
            //         AppConstants.copyright,
            //         style: Theme.of(
            //           context,
            //         ).textTheme.bodyMedium?.copyWith(color: AppColors.gray400),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
