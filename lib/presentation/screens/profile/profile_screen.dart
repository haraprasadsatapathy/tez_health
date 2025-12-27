import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/presentation/cubit/theme/theme_bloc.dart';
import 'package:tez_health/presentation/cubit/theme/theme_event.dart';
import 'package:tez_health/presentation/cubit/theme/theme_state.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/presentation/widgets/theme_toggle_icon.dart';
import 'package:tez_health/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        actions: [
          ThemeToggleIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.trustBlue.withValues(alpha: 0.1),
                      AppTheme.trustBlue.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppTheme.trustBlue.withValues(alpha: 0.2),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: AppTheme.trustBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@email.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+1 234 567 8900',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '3',
                      'Bookings',
                      Icons.calendar_today,
                      AppTheme.trustBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '5',
                      'Orders',
                      Icons.shopping_bag,
                      AppTheme.successGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '2',
                      'Certificates',
                      Icons.school,
                      AppTheme.warningOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Menu Items
              _buildMenuItem(
                context,
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.history,
                title: 'Booking History',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.shopping_bag_outlined,
                title: 'Order History',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.card_membership,
                title: 'My Certifications',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.favorite_outline,
                title: 'Saved Items',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.payment,
                title: 'Payment Methods',
                onTap: () {},
              ),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  final isDarkMode = state.themeMode == ThemeMode.dark;
                  return _buildMenuItem(
                    context,
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(const ToggleThemeEvent());
                      },
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {},
                textColor: AppTheme.alertRed,
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String count,
    String label,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              count,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.mediumGrey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: textColor ?? AppTheme.mediumGrey),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.mediumGrey,
            ),
        onTap: onTap,
      ),
    );
  }
}
