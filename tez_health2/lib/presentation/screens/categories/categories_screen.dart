import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../cubit/categories/categories_bloc.dart';
import '../../cubit/categories/categories_event.dart';
import '../../cubit/categories/categories_state.dart';
import '../../widgets/common/category_card.dart';
import '../../widgets/common/menu_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CategoriesScreenContent();
  }
}

class _CategoriesScreenContent extends StatefulWidget {
  const _CategoriesScreenContent();

  @override
  State<_CategoriesScreenContent> createState() =>
      _CategoriesScreenContentState();
}

class _CategoriesScreenContentState extends State<_CategoriesScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/app_icon/app_icon.jpeg'),
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
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
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context
                    .read<CategoriesBloc>()
                    .add(SearchCategoriesEvent(value));
              },
              decoration: InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(
                  color: AppColors.gray400,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.gray400,
                  size: 20.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.gray400,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<CategoriesBloc>()
                              .add(const SearchCategoriesEvent(''));
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),

          // Categories Grid
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage!,
                          style: TextStyle(
                            color: AppColors.gray600,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<CategoriesBloc>()
                                .add(const LoadCategoriesEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.filteredCategories.isEmpty) {
                  return Center(
                    child: Text(
                      state.searchQuery.isNotEmpty
                          ? 'No categories found'
                          : 'No categories available',
                      style: TextStyle(
                        color: AppColors.gray600,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<CategoriesBloc>()
                        .add(const RefreshCategoriesEvent());
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: state.filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = state.filteredCategories[index];
                      return CategoryCard(
                        category: category,
                        onTap: () {
                          context.push(
                            '/products/${category.categoryId}?name=${Uri.encodeComponent(category.name)}',
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
