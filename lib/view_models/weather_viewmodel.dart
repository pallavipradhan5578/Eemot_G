import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WeatherViewModel extends ChangeNotifier {
  String area = '';        // 🆕 Added for locality or area (e.g., Keshri Nagar)
  String city = '';        // City name (e.g., Patna)
  String temperature = ''; // Temperature (e.g., 22.5°C)
  String condition = '';   // Weather condition (e.g., Clear)
  bool isLoading = false;

  Future<void> fetchWeather() async {
    isLoading = true;
    notifyListeners();

    try {
      // ✅ 1. Get current location
      Position position = await _determinePosition();

      // ✅ 2. Convert coordinates to area + city name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        area = placemarks.first.subLocality ?? ''; // Example: Keshri Nagar
        city = placemarks.first.locality ?? '';    // Example: Patna
      }

      // ✅ 3. Call Visual Crossing API
      const apiKey = '33DFSEEXNKBFHKXUAME7CQCT6'; // Your Visual Crossing API key
      final url = Uri.parse(
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city?unitGroup=metric&key=$apiKey&contentType=json',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final current = data['currentConditions'];

        temperature = '${current['temp']}°C';
        condition = current['conditions'];
      } else {
        temperature = '--';
        condition = 'Error';
      }
    } catch (e) {
      temperature = '--';
      condition = 'Failed';
      city = 'Location Error';
      area = '';
      debugPrint('Error fetching weather: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // ✅ Location permission & fetching logic
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // ✅ Return current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
