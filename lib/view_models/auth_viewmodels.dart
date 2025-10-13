import 'package:flutter/material.dart';
import 'package:gps/data/repositories/auth_repository.dart';
import 'package:gps/core/services/storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Register Method
  Future<bool> register({
    required String name,
    required String email,
    required String mobileNumber,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('🎯 Starting registration...');

      final response = await _repository.register(
        name: name,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
      );

      print('💾 Saving to SharedPreferences...');
      await StorageService.saveUserData(
        token: response.token,
        userId: response.user.id,
        name: response.user.name,
        email: response.user.email,
        mobile: response.user.mobileNumber,
      );

      print('✅ Registration successful!');
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('❌ Register Error: $e');
      _errorMessage = _getErrorMessage(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Login Method
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('🎯 Starting login...');

      final response = await _repository.login(
        email: email,
        password: password,
      );

      print('💾 Saving to SharedPreferences...');
      await StorageService.saveUserData(
        token: response.token,
        userId: response.user.id,
        name: response.user.name,
        email: response.user.email,
        mobile: response.user.mobileNumber,
      );

      print('✅ Login successful!');
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('❌ Login Error: $e');
      _errorMessage = _getErrorMessage(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('Internet connection')) {
      return 'Internet connection nahi hai. WiFi/Data check karo.';
    } else if (error.contains('timeout')) {
      return 'Server response slow hai. Thodi der baad try karo.';
    } else if (error.contains('Validation')) {
      return error.replaceAll('Exception: ', '');
    } else if (error.contains('401') || error.contains('422')) {
      return 'Email ya Password galat hai.';
    } else if (error.contains('Server error') || error.contains('500')) {
      return 'Server mein problem hai. Thodi der baad try karo.';
    } else {
      return 'Kuch galat ho gaya. Phir se try karo.';
    }
  }
}


class UserViewModel extends ChangeNotifier {
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  String get name => _userData?['name'] ?? 'User';
  String get email => _userData?['email'] ?? 'email@example.com';
  String get mobile => _userData?['mobile'] ?? '0000000000';
  String get token => _userData?['token'] ?? '';

  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();

    _userData = await StorageService.getUserData();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await StorageService.clearUserData();
    _userData = null;
    notifyListeners();
  }
}