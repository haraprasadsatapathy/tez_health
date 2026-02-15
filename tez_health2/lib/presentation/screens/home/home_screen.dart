import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../models/popular_service_response.dart';
import '../../../models/search_result.dart';
import '../../cubit/home/home_bloc.dart';
import '../../cubit/home/home_event.dart';
import '../../cubit/home/home_state.dart';
import '../../cubit/tab_navigation/tab_navigation_bloc.dart';
import '../../cubit/tab_navigation/tab_navigation_event.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../../cubit/theme/theme_state.dart';
import '../../widgets/home/hero_carousel.dart';
import '../../widgets/home/top_categories_section.dart';
import '../../widgets/home/popular_services_section.dart';
import '../../widgets/common/menu_drawer.dart';
import '../../../utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeScreenContent();
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<PopularServiceData> listPopularServiceData=[];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _isSearching = false;
        context.read<HomeBloc>().add(const FetchCategoriesEvent());
        context.read<HomeBloc>().add(const FetchPopularServiceEvent());
      } else {
        _isSearching = true;
        context.read<HomeBloc>().add(SearchProductsEvent(value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Image.asset(AppConstants.logoBlue, height: 36)]),
        actions: [
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
      body: Column(
        children: [
          // Search Field (always visible)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for products, services...',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),

          // Content area
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if(state is HomeInitial){
                  context.read<HomeBloc>().add(const FetchCategoriesEvent());
                  context.read<HomeBloc>().add(const FetchPopularServiceEvent());
                }
                // Show search results when searching
                if (_isSearching && state is SearchResultsLoaded) {
                  return _buildSearchResults(state.results);
                }

                // Show normal home content
                return SingleChildScrollView(
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
                      return Column(
                        children: [
                          TopCategoriesSection(
                            categories: state.categories,
                            onViewMoreTap: (){
                              context.read<TabNavigationBloc>().add(const TabChangedEvent(1));
                            },
                            onCategoryTap: (category) {
                              context.push(
                                '/products/${category.categoryId}?name=${Uri.encodeComponent(category.name)}',
                              );
                            },
                          ),
                          const PopularServicesSection(),
                        ],
                      );
                    } else if (state is PopularServiceDataLoaded) {
                      return Column(
                        children: [
                          const PopularServicesSection(),
                        ],
                      );
                    }else if (state is HomeError) {
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

                  // From anywhere in your app

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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<SearchResult> results) {
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No products found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Try searching with different keywords',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    // Remove duplicates based on productId
    final uniqueResults = <String, SearchResult>{};
    for (var result in results) {
      uniqueResults[result.productId] = result;
    }
    final uniqueList = uniqueResults.values.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: uniqueList.length,
      itemBuilder: (context, index) {
        final result = uniqueList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.medical_services),
            ),
            title: Text(
              result.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.push('/product-details/${result.productId}');
            },
          ),
        );
      },
    );
  }
}
