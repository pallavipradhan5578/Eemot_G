// lib/view_models/my_vehicle_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:gps/view_models/vehicle_model.dart';
import '../data/models/vehicle_details_model.dart';

class MyVehicleViewModel extends ChangeNotifier {
  final VehicleApiService _apiService = VehicleApiService();

  List<VehicleDetailsModel> _allVehicles = [];
  List<VehicleDetailsModel> _activeVehicles = [];
  List<VehicleDetailsModel> _inactiveVehicles = [];

  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<VehicleDetailsModel> get allVehicles => _allVehicles;
  List<VehicleDetailsModel> get activeVehicles => _activeVehicles;
  List<VehicleDetailsModel> get inactiveVehicles => _inactiveVehicles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch vehicles from API
  Future<void> fetchVehicles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allVehicles = await _apiService.fetchUserVehicles();

      // Active = status "Processing" or "complete"
      _activeVehicles = _allVehicles
          .where((vehicle) {
        final status = vehicle.status.toString().toLowerCase();
        return status == 'processing' || status == 'complete';
      })
          .toList();

      // Inactive = everything else
      _inactiveVehicles = _allVehicles
          .where((vehicle) {
        final status = vehicle.status.toString().toLowerCase();
        return status != 'processing' && status != 'complete';
      })
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh vehicles
  Future<void> refreshVehicles() async {
    await fetchVehicles();
  }

  // Helper method to get status text
  String getStatusText(dynamic status) {
    final s = status.toString().toLowerCase();
    if (s == 'processing') return 'Processing';
    if (s == 'complete') return 'Active';
    if (s == 'pending') return 'Inactive';
    return 'Inactive';
  }

  // Helper method to get status color
  Color getStatusColor(dynamic status) {
    final s = status.toString().toLowerCase();
    if (s == 'processing') return Colors.orange;
    if (s == 'complete') return Colors.green;
    if (s == 'pending') return Colors.red;
    return Colors.red;
  }
}
