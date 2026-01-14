import 'package:equatable/equatable.dart';

class BookingResponse extends Equatable {
  final int statusCode;
  final String message;
  final bool emailSent;

  const BookingResponse({
    required this.statusCode,
    required this.message,
    required this.emailSent,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      emailSent: json['emailSent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'emailSent': emailSent,
    };
  }

  @override
  List<Object?> get props => [statusCode, message, emailSent];
}
