import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_colors.dart';
import '../../cubit/tab_navigation/tab_navigation_bloc.dart';
import '../../cubit/tab_navigation/tab_navigation_event.dart';
import '../../cubit/tab_navigation/tab_navigation_state.dart';
import '../home/home_screen.dart';
import '../categories/categories_screen.dart';
import '../suraksha/suraksha_screen.dart';
import '../store/store_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabNavigationBloc(),
      child: const _MainNavigationScreenContent(),
    );
  }
}

class _MainNavigationScreenContent extends StatefulWidget {
  const _MainNavigationScreenContent();

  @override
  State<_MainNavigationScreenContent> createState() =>
      _MainNavigationScreenContentState();
}

class _MainNavigationScreenContentState
    extends State<_MainNavigationScreenContent> {
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    SurakshaScreen(),
    StoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationBloc, TabNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentTabIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context: context,
                      index: 0,
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: 'Home',
                      currentIndex: state.currentTabIndex,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 1,
                      icon: Icons.grid_view_outlined,
                      activeIcon: Icons.grid_view,
                      label: 'Categories',
                      currentIndex: state.currentTabIndex,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 2,
                      icon: Icons.shield_outlined,
                      activeIcon: Icons.shield,
                      label: 'Suraksha',
                      currentIndex: state.currentTabIndex,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 3,
                      icon: Icons.store_outlined,
                      activeIcon: Icons.store,
                      label: 'Store',
                      currentIndex: state.currentTabIndex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int currentIndex,
  }) {
    final isActive = currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveColor = isDark ? AppColors.gray400 : AppColors.gray500;

    return GestureDetector(
      onTap: () {
        context.read<TabNavigationBloc>().add(TabChangedEvent(index));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.tezBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 24.sp,
              color: isActive ? AppColors.tezBlue : inactiveColor,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.tezBlue : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
