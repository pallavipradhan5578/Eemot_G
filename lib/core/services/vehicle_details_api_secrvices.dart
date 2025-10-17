// lib/data/services/vehicle_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../view_models/vehicle_model.dart';

import 'storage_service.dart';

class VehicleApiService {
  static const String baseUrl = 'https://erp.eemotrack.com/api/v1';

  Future<List<VehicleDetailsModel>> fetchUserVehicles() async {
    try {
      // Get user data from storage
      final userData = await StorageService.getUserData();
      print("👤 User Data: $userData");

      if (userData == null || userData['userId'] == null) {
        throw Exception('User not logged in');
      }

      final userId = userData['userId'];
      final token = userData['token'];
      final url = '$baseUrl/vehicles-by-user/$userId';

      print("🌐 API URL: $url");
      print("🔑 Token: ${token?.substring(0, 20)}...");

      // API call
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print("📡 Status Code: ${response.statusCode}");
      print("📄 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        print("🔍 Parsed JSON: $jsonData");

        // Handle different response structures
        List<dynamic> vehiclesList = [];

        if (jsonData is List) {
          // If response is directly an array
          vehiclesList = jsonData;
        } else if (jsonData is Map<String, dynamic>) {
          // If response is an object with data key
          if (jsonData['data'] != null) {
            vehiclesList = jsonData['data'] as List;
          } else if (jsonData['vehicles'] != null) {
            vehiclesList = jsonData['vehicles'] as List;
          } else if (jsonData['result'] != null) {
            vehiclesList = jsonData['result'] as List;
          }
        }

        print("✅ Found ${vehiclesList.length} vehicles");

        if (vehiclesList.isEmpty) {
          print("⚠️ No vehicles found in response");
          return [];
        }

        List<VehicleDetailsModel> vehicles = vehiclesList
            .map((json) {
          print("🚗 Parsing vehicle: $json");
          return VehicleDetailsModel.fromJson(json);
        })
            .toList();

        print("✅ Successfully parsed ${vehicles.length} vehicles");
        return vehicles;
      } else {
        throw Exception('Failed to load vehicles: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching vehicles: $e");
      print("📚 Stack trace: $stackTrace");
      throw Exception('Error fetching vehicles: $e');
    }
  }
}