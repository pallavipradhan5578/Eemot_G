import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/models/vehicle_type_model.dart';


class VehicleTypeViewModel extends ChangeNotifier {
  List<VehicleTypeModel> _vehicleTypes = [];
  bool _isLoading = false;

  List<VehicleTypeModel> get vehicleTypes => _vehicleTypes;
  bool get isLoading => _isLoading;

  Future<void> fetchVehicleTypes() async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://erp.eemotrack.com/api/v1/vehicle-types';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        _vehicleTypes = data.map((e) => VehicleTypeModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
