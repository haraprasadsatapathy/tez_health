import '../base_event_state.dart';

abstract class CallbackEvent extends BaseEventState {
  const CallbackEvent();
}

class ScheduleCallbackEvent extends CallbackEvent {
  final String productId;
  final String productName;
  final String name;
  final String mobile;
  final String location;
  final DateTime preferredDate;

  const ScheduleCallbackEvent({
    required this.productId,
    required this.productName,
    required this.name,
    required this.mobile,
    required this.location,
    required this.preferredDate,
  });

  @override
  List<Object?> get props => [
        productId,
        productName,
        name,
        mobile,
        location,
        preferredDate,
      ];
}
