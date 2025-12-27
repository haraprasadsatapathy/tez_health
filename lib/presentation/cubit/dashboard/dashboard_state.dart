import 'package:tez_health/presentation/cubit/base/base_event_state.dart';

abstract class DashboardState extends BaseEventState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardTabChanged extends DashboardState {
  final int currentTabIndex;

  const DashboardTabChanged(this.currentTabIndex);

  @override
  List<Object?> get props => [currentTabIndex];
}
