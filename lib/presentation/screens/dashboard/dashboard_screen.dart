import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_bloc.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_event.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_state.dart';
import 'package:tez_health/presentation/screens/emergency/emergency_screen.dart';
import 'package:tez_health/presentation/screens/healthcare/healthcare_screen.dart';
import 'package:tez_health/presentation/screens/store/store_screen.dart';
import 'package:tez_health/presentation/screens/academy/academy_screen.dart';
import 'package:tez_health/presentation/widgets/sos_button.dart';
import 'package:tez_health/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is DashboardTabChanged) {
          currentIndex = state.currentTabIndex;
        }

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              EmergencyScreen(),
              HealthcareScreen(),
              StoreScreen(),
              AcademyScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<DashboardBloc>().add(ChangeTabEvent(index));
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.trustBlue,
            unselectedItemColor: AppTheme.mediumGrey,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: 'Rescue',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                label: 'Care',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Mart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Academy',
              ),
            ],
          ),
          floatingActionButton: const SOSButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
