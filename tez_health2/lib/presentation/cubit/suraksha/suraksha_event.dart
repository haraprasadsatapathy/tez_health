import '../base_event_state.dart';

abstract class SurakshaEvent extends BaseEvent {
  const SurakshaEvent();
}

class LoadSurakshaEvent extends SurakshaEvent {
  const LoadSurakshaEvent();

  @override
  List<Object?> get props => [];
}

class RefreshSurakshaEvent extends SurakshaEvent {
  const RefreshSurakshaEvent();

  @override
  List<Object?> get props => [];
}
