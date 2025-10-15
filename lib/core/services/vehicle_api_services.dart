import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleApiService {
  static const String baseUrl = 'https://erp.eemotrack.com/api/v1';

  Future<Map<String, dynamic>> addCustomerVehicle({
    required String vehicleNumber,
    required String ownersName,
    required String insuranceExpiryDate,
    required String chassisNumber,
    required String vehicleModel,
    required String vehicleColor,
    required String engineNumber,
    required String userId,
    required String createdById,
    required String vehicleType,
    String status = '1',
    String activated = '1',
    File? vehiclePhoto,
    File? idProof,
    File? insuranceDoc,
    File? pollutionDoc,
    File? rcDoc,
    File? productImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/add-customer-vehicle'),
      );

      // Add text fields
      request.fields['vehicle_number'] = vehicleNumber;
      request.fields['owners_name'] = ownersName;
      request.fields['insurance_expiry_date'] = insuranceExpiryDate;
      request.fields['chassis_number'] = chassisNumber;
      request.fields['vehicle_model'] = vehicleModel;
      request.fields['vehicle_color'] = vehicleColor;
      request.fields['engine_number'] = engineNumber;
      request.fields['user_id'] = userId;
      request.fields['created_by_id'] = createdById;
      request.fields['status'] = status;
      request.fields['activated'] = activated;
      request.fields['vehicle_type'] = vehicleType;

      // Add image files
      if (vehiclePhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_photo',
          vehiclePhoto.path,
        ));
      }

      if (idProof != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'id_proof',
          idProof.path,
        ));
      }

      if (insuranceDoc != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'insurance_doc',
          insuranceDoc.path,
        ));
      }

      if (pollutionDoc != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'pollution_doc',
          pollutionDoc.path,
        ));
      }

      if (rcDoc != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'rc_doc',
          rcDoc.path,
        ));
      }

      if (productImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'product_image',
          productImage.path,
        ));
      }

      // Add authorization header if needed
      // request.headers['Authorization'] = 'Bearer YOUR_TOKEN';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to add vehicle: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}