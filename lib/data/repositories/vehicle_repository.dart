import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/add_vehicle.dart';


class VehicleRepository {
  static const String baseUrl = 'https://erp.eemotrack.com/api/v1';

  Future<AddVehicleResponse> addCustomerVehicle({
    required AddVehicleRequest request,
    File? vehiclePhoto,
    File? idProof,
    File? insuranceDoc,
    File? pollutionDoc,
    File? rcDoc,
    File? productImage,
    String? authToken,
  }) async {
    try {
      var httpRequest = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/add-customer-vehicle'),
      );

      // Add text fields
      httpRequest.fields['vehicle_number'] = request.vehicleNumber;
      httpRequest.fields['owners_name'] = request.ownersName;
      httpRequest.fields['insurance_expiry_date'] = request.insuranceExpiryDate;
      httpRequest.fields['chassis_number'] = request.chassisNumber;
      httpRequest.fields['vehicle_model'] = request.vehicleModel;
      httpRequest.fields['vehicle_color'] = request.vehicleColor;
      httpRequest.fields['engine_number'] = request.engineNumber;
      httpRequest.fields['user_id'] = request.userId;
      httpRequest.fields['created_by_id'] = request.createdById;
      httpRequest.fields['status'] = request.status;
      httpRequest.fields['activated'] = request.activated;
      httpRequest.fields['vehicle_type'] = request.vehicleType;

      // Add authorization header if token exists
      if (authToken != null && authToken.isNotEmpty) {
        httpRequest.headers['Authorization'] = 'Bearer $authToken';
      }

      // Add image files
      if (vehiclePhoto != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'vehicle_photo',
          vehiclePhoto.path,
        ));
      }

      if (idProof != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'id_proof',
          idProof.path,
        ));
      }

      if (insuranceDoc != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'insurance_doc',
          insuranceDoc.path,
        ));
      }

      if (pollutionDoc != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'pollution_doc',
          pollutionDoc.path,
        ));
      }

      if (rcDoc != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'rc_doc',
          rcDoc.path,
        ));
      }

      if (productImage != null) {
        httpRequest.files.add(await http.MultipartFile.fromPath(
          'product_image',
          productImage.path,
        ));
      }

      var streamedResponse = await httpRequest.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return AddVehicleResponse.fromJson(jsonData);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to add vehicle');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}