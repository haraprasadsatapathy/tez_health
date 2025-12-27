import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_event.dart';
import 'package:tez_health/presentation/cubit/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<ChangeTabEvent>(_onChangeTab);
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<DashboardState> emit) {
    emit(DashboardTabChanged(event.tabIndex));
  }
}
