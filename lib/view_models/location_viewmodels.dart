import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import '../core/services/location_services.dart';

class LocationViewModel extends ChangeNotifier {
  Position? _currentPosition;
  String _address = 'Fetching location...';
  bool _isLoading = false;
  String? _error;

  Position? get currentPosition => _currentPosition;
  String get address => _address;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Default location (Patna, Bihar)
  double get latitude => _currentPosition?.latitude ?? 25.5941;
  double get longitude => _currentPosition?.longitude ?? 85.1376;

  Future<void> fetchCurrentLocation() async {
    print('🎯 fetchCurrentLocation called');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('📡 Requesting location...');
      _currentPosition = await LocationService.getCurrentLocation();

      if (_currentPosition != null) {
        print('✅ Location received: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}');
        _address = await LocationService.getAddressFromLatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );
      } else {
        print('⚠️ Location is null, using default');
        _address = 'Keshri Nagar, Patna (Default)';
      }
    } catch (e) {
      print('❌ Location error: $e');
      _error = e.toString();
      _address = 'Keshri Nagar, Patna (Error: $e)';
    } finally {
      _isLoading = false;
      print('✅ Location fetch completed');
      notifyListeners();
    }
  }
}