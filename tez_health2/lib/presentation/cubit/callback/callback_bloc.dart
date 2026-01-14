import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../domain/repository/tez_repository.dart';
import '../../../models/booking_request.dart';
import 'callback_event.dart';
import 'callback_state.dart';

class CallbackBloc extends Bloc<CallbackEvent, CallbackState> {
  final TezRepository _repository;

  CallbackBloc(this._repository) : super(const CallbackInitial()) {
    on<ScheduleCallbackEvent>(_onScheduleCallback);
  }

  Future<void> _onScheduleCallback(
    ScheduleCallbackEvent event,
    Emitter<CallbackState> emit,
  ) async {
    try {
      emit(const CallbackLoading());

      // Format date as "d-MM-yyyy" (e.g., "1-01-2026")
      final formattedDate = DateFormat('d-MM-yyyy').format(event.preferredDate);

      // Create booking request
      final bookingRequest = BookingRequest(
        name: event.name,
        mobile: event.mobile,
        serviceName: event.productName,
        location: event.location,
        serviceRequiredOn: formattedDate,
      );

      // Debug: Print request data
      print('📋 Booking Request Data: ${bookingRequest.toJson()}');

      // Call API
      final response = await _repository.scheduleCallback(bookingRequest);

      // Check response
      if (response.statusCode == 200) {
        emit(CallbackSuccess(
          response.message.isNotEmpty
              ? response.message
              : 'Callback scheduled successfully! Our experts will call you back within 2 hours.',
        ));
      } else {
        emit(CallbackError(
          response.message.isNotEmpty
              ? response.message
              : 'Failed to schedule callback. Please try again.',
        ));
      }
    } catch (e) {
      print('❌ Callback Error: $e');
      emit(CallbackError('Failed to schedule callback: ${e.toString()}'));
    }
  }
}
