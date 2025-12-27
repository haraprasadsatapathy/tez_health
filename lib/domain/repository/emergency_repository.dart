import 'package:tez_health/data/data_source/api_client.dart';
import 'package:tez_health/utils/constants.dart';

class EmergencyRepository {
  final ApiClient _apiClient;

  EmergencyRepository(this._apiClient);

  // Trigger SOS
  Future<Map<String, dynamic>> triggerSOS({
    required double latitude,
    required double longitude,
    String? message,
  }) async {
    try {
      final response = await _apiClient.post(
        AppConstants.sosEndpoint,
        data: {
          'latitude': latitude,
          'longitude': longitude,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Book Ambulance
  Future<Map<String, dynamic>> bookAmbulance({
    required String type, // BLS, ALS, MORTUARY
    required double pickupLat,
    required double pickupLon,
    required String pickupAddress,
    required double dropLat,
    required double dropLon,
    required String dropAddress,
    String? patientName,
    String? contactNumber,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        AppConstants.ambulanceBookingEndpoint,
        data: {
          'type': type,
          'pickup': {
            'latitude': pickupLat,
            'longitude': pickupLon,
            'address': pickupAddress,
          },
          'drop': {
            'latitude': dropLat,
            'longitude': dropLon,
            'address': dropAddress,
          },
          'patient_name': patientName,
          'contact_number': contactNumber,
          'notes': notes,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Get Nearby Hospitals
  Future<List<dynamic>> getNearbyHospitals({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
  }) async {
    try {
      final response = await _apiClient.get(
        AppConstants.hospitalNetworkEndpoint,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'radius': radiusKm,
        },
      );
      return response.data['hospitals'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  // Get Hospital Details
  Future<Map<String, dynamic>> getHospitalDetails(String hospitalId) async {
    try {
      final response = await _apiClient.get(
        '${AppConstants.hospitalNetworkEndpoint}/$hospitalId',
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Track Ambulance
  Future<Map<String, dynamic>> trackAmbulance(String bookingId) async {
    try {
      final response = await _apiClient.get(
        '${AppConstants.ambulanceBookingEndpoint}/$bookingId/track',
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Cancel Ambulance Booking
  Future<Map<String, dynamic>> cancelAmbulanceBooking(String bookingId) async {
    try {
      final response = await _apiClient.post(
        '${AppConstants.ambulanceBookingEndpoint}/$bookingId/cancel',
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
