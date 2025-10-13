import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> post(
      String url,
      Map<String, dynamic> body,
      ) async {
    try {
      print('Making request to: $url');
      print('Request body: ${json.encode(body)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {

        String errorMessage = 'Error: ${response.statusCode}';
        try {
          final errorBody = json.decode(response.body);
          errorMessage = errorBody['message'] ?? errorMessage;
        } catch (_) {
          errorMessage = response.body.isNotEmpty
              ? response.body
              : errorMessage;
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Exception occurred: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection');
      } else if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timeout');
      }
      throw Exception('Network error: $e');
    }
  }
}