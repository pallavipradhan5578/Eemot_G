import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    try {
      print('🔐 Checking location permission...');

      // Check permission
      var permission = await Permission.location.status;
      print('📋 Current permission status: $permission');

      if (permission.isDenied) {
        print('❓ Requesting location permission...');
        permission = await Permission.location.request();
        print('📋 Permission after request: $permission');
      }

      if (permission.isDenied) {
        print('❌ Location permission denied');
        throw Exception('Location permission denied');
      }

      if (permission.isPermanentlyDenied) {
        print('❌ Location permission permanently denied');
        throw Exception('Location permission permanently denied. Please enable from settings.');
      }

      // Check if location services are enabled
      print('🛰️ Checking location services...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print('📡 Location services enabled: $serviceEnabled');

      if (!serviceEnabled) {
        print('❌ Location services are disabled');
        throw Exception('Location services are disabled. Please enable GPS.');
      }

      print('📍 Getting current position...');
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      print('✅ Position obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('❌ Location Error: $e');
      return null;
    }
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    // TODO: Use geocoding package to get actual address
    // For now returning default
    return 'Lat: ${lat.toStringAsFixed(4)}, Lng: ${lng.toStringAsFixed(4)}';
  }
}