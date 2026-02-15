import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/common/menu_drawer.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

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
          'Store',
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),

                // Coming Soon Image
                Image.asset(
                  'assets/images/work-in-progress.png', // Update this path
                  width: 300.w,
                  height: 300.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 48.h),

                // Description Text
                Text(
                  'Order medicines from your nearest medical store and get delivered in 30 minutes.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.gray700,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),

                // Back to Home Page Button
                OutlinedButton.icon(
                  onPressed: () {
                    context.go('/');
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    size: 20.sp,
                    color: const Color(0xFF4A5568),
                  ),
                  label: Text(
                    'Back to Home Page',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF4A5568),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 16.h,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}