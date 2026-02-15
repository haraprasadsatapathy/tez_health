import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_constants.dart';
import '../../widgets/common/menu_drawer.dart';

class TezPlusScreen extends StatelessWidget {
  const TezPlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/app_icon/app_icon.jpeg'),
          ),
        ),
        title: Text(
          'Tez Plus',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(1),
        child: Column(
          children: [
            // Banner
            AspectRatio(
              aspectRatio: 16 / 9,
              child:  Image.asset(
                'assets/images/tezplus2.jpeg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),


            SizedBox(height: 15),

            Text('Benefits', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            // Benefits
            ListTile(leading: Text('🚑', style: TextStyle(fontSize: 28)), title: Text('24x7 Emergency assistance')),
            ListTile(leading: Text('👨‍⚕️', style: TextStyle(fontSize: 28)), title: Text('Unlimited Doctor consultations')),
            ListTile(leading: Text('🚨', style: TextStyle(fontSize: 28)), title: Text('Free Emergency Ambulance')),
            ListTile(leading: Text('🏠', style: TextStyle(fontSize: 28)), title: Text('Up to 20% discount on Home Care & Diagnostics')),
            ListTile(leading: Text('💊', style: TextStyle(fontSize: 28)), title: Text('Up to 10% discount on Medical items')),
            ListTile(leading: Text('🎓', style: TextStyle(fontSize: 28)), title: Text('Access to Webinars & Training Programs')),

            SizedBox(height: 12),

            // Button
            ElevatedButton(
              onPressed: () {
                buildShowDialog(context);

              },
              child: Text('Launching Soon - Join the Waitlist'),
            ),

            SizedBox(height: 20), // Added some bottom padding
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),// <-- Easy top & bottom space
              child: Column(
                mainAxisSize: MainAxisSize.min, // 🔥 THIS IS IMPORTANT
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Join the Waitlist",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  // Full Name Field
                  _buildTextField(hint: "Full Name"),
                  SizedBox(height: 16.h),

                  // Phone Number Field
                  _buildTextField(hint: "Phone Number", keyboardType: TextInputType.phone),
                  SizedBox(height: 16.h),

                  // Email Field
                  _buildTextField(hint: "Email Address", keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 16.h),

                  // Message Field
                  _buildTextField(
                    hint: "Whom do you need this for?",
                    maxLines: 4,
                  ),
                  SizedBox(height: 30.h),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3), // Bright blue
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // Add your submission logic here
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Join Waitlist",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }


  // Helper method for consistent styling
  Widget _buildTextField({required String hint, int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
}
}