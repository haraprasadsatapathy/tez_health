import 'package:equatable/equatable.dart';

/// Base class for all events in the app
/// This provides a common structure for BLoC pattern
class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

/// Base class for all states in the app
/// This provides a common structure for BLoC pattern
class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

/// Legacy base class for backwards compatibility
class BaseEventState extends Equatable {
  const BaseEventState();

  @override
  List<Object?> get props => [];
}
