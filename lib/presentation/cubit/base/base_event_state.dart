import 'package:equatable/equatable.dart';

/// Base class for all BLoC events and states
/// Extends Equatable for value comparison
abstract class BaseEventState extends Equatable {
  const BaseEventState();

  @override
  List<Object?> get props => [];
}
