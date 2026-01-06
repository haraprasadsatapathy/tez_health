import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_navigation_event.dart';
import 'tab_navigation_state.dart';

class TabNavigationBloc extends Bloc<TabNavigationEvent, TabNavigationState> {
  TabNavigationBloc() : super(const TabNavigationState()) {
    on<TabChangedEvent>(_onTabChanged);
  }

  void _onTabChanged(
    TabChangedEvent event,
    Emitter<TabNavigationState> emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
  }
}
