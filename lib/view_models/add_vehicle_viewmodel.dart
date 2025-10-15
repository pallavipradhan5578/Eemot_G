import 'dart:io';
import 'package:flutter/material.dart';

import '../data/models/add_vehicle.dart';
import '../data/repositories/vehicle_repository.dart';


class AddVehicleViewModel extends ChangeNotifier {
  final VehicleRepository _repository = VehicleRepository();

  bool _isLoading = false;
  String? _errorMessage;
  AddVehicleResponse? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AddVehicleResponse? get response => _response;

  Future<bool> addVehicle({
    required AddVehicleRequest request,
    File? vehiclePhoto,
    File? idProof,
    File? insuranceDoc,
    File? pollutionDoc,
    File? rcDoc,
    File? productImage,
    String? authToken,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _response = await _repository.addCustomerVehicle(
        request: request,
        vehiclePhoto: vehiclePhoto,
        idProof: idProof,
        insuranceDoc: insuranceDoc,
        pollutionDoc: pollutionDoc,
        rcDoc: rcDoc,
        productImage: productImage,
        authToken: authToken,
      );

      _isLoading = false;
      notifyListeners();
      return _response?.status ?? false;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception:', '').trim();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _response = null;
    notifyListeners();
  }


}