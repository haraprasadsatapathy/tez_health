import 'package:tez_health/presentation/cubit/base/base_event_state.dart';

abstract class DashboardEvent extends BaseEventState {
  const DashboardEvent();
}

class ChangeTabEvent extends DashboardEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
