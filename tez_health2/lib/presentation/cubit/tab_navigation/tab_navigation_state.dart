import '../base_event_state.dart';

class TabNavigationState extends BaseState {
  final int currentTabIndex;

  const TabNavigationState({
    this.currentTabIndex = 0,
  });

  TabNavigationState copyWith({
    int? currentTabIndex,
  }) {
    return TabNavigationState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [currentTabIndex];
}
