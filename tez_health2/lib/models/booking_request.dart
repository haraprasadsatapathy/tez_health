import 'package:equatable/equatable.dart';

class BookingRequest extends Equatable {
  final String name;
  final String mobile;
  final String serviceName;
  final String location;
  final String serviceRequiredOn;

  const BookingRequest({
    required this.name,
    required this.mobile,
    required this.serviceName,
    required this.location,
    required this.serviceRequiredOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Mobile': mobile,
      'ServiceName': serviceName,
      'Location': location,
      'Service_required_on': serviceRequiredOn,
    };
  }

  @override
  List<Object?> get props => [
        name,
        mobile,
        serviceName,
        location,
        serviceRequiredOn,
      ];
}
