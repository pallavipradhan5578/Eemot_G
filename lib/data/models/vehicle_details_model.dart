// lib/data/services/vehicle_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/services/storage_service.dart';
import '../../view_models/vehicle_model.dart';
import '../models/vehicle_details_model.dart';

class VehicleApiService {
  static const String baseUrl = 'https://erp.eemotrack.com/api/v1';

  Future<List<VehicleDetailsModel>> fetchUserVehicles() async {
    try {
      // Get user data from storage
      final userData = await StorageService.getUserData();
      if (userData == null || userData['userId'] == null) {
        throw Exception('User not logged in');
      }

      final userId = userData['userId'];
      final token = userData['token'];

      // API call
      final response = await http.get(
        Uri.parse('$baseUrl/vehicles-by-user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // If your API requires token
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Assuming API response structure is: { "data": [...], "status": true }
        if (jsonData['data'] != null) {
          List<dynamic> vehiclesList = jsonData['data'];
          return vehiclesList
              .map((json) => VehicleDetailsModel.fromJson(json))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to load vehicles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vehicles: $e');
    }
  }
}