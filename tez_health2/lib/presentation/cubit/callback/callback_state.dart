import '../base_event_state.dart';

abstract class CallbackState extends BaseEventState {
  const CallbackState();
}

class CallbackInitial extends CallbackState {
  const CallbackInitial();
}

class CallbackLoading extends CallbackState {
  const CallbackLoading();
}

class CallbackSuccess extends CallbackState {
  final String message;

  const CallbackSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CallbackError extends CallbackState {
  final String message;

  const CallbackError(this.message);

  @override
  List<Object?> get props => [message];
}
