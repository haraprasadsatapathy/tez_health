import 'package:flutter_bloc/flutter_bloc.dart';
import 'suraksha_event.dart';
import 'suraksha_state.dart';

class SurakshaBloc extends Bloc<SurakshaEvent, SurakshaState> {
  SurakshaBloc() : super(const SurakshaState()) {
    on<LoadSurakshaEvent>(_onLoadSuraksha);
    on<RefreshSurakshaEvent>(_onRefreshSuraksha);
  }

  Future<void> _onLoadSuraksha(
    LoadSurakshaEvent event,
    Emitter<SurakshaState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // TODO: Implement API call to fetch Suraksha data
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        isLoading: false,
        surakshaItems: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load Suraksha: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRefreshSuraksha(
    RefreshSurakshaEvent event,
    Emitter<SurakshaState> emit,
  ) async {
    try {
      // TODO: Implement API call to refresh Suraksha data
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        surakshaItems: [],
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to refresh Suraksha: ${e.toString()}',
      ));
    }
  }
}
