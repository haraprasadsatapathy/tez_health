import '../base_event_state.dart';

abstract class TabNavigationEvent extends BaseEvent {
  const TabNavigationEvent();
}

class TabChangedEvent extends TabNavigationEvent {
  final int tabIndex;

  const TabChangedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
