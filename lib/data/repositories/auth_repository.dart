import 'package:gps/core/constants/api_urls.dart';
import 'package:gps/core/services/api_service.dart';
import 'package:gps/data/models/register_response_model.dart';
import 'package:gps/data/models/login_response_model.dart';

class AuthRepository {
  // Register Method
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String mobileNumber,
    required String password,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'mobile_number': mobileNumber,
        'password': password,
      };

      print('🔄 Calling Register API...');
      final response = await ApiService.post(ApiUrls.register, body);
      print('✅ Register Response received');

      return RegisterResponseModel.fromJson(response);
    } catch (e) {
      print('❌ Register Repository Error: $e');
      rethrow;
    }
  }

  // Login Method
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      print('🔄 Calling Login API...');
      final response = await ApiService.post(ApiUrls.login, body);
      print('✅ Login Response received');

      return LoginResponseModel.fromJson(response);
    } catch (e) {
      print('❌ Login Repository Error: $e');
      rethrow;
    }
  }
}