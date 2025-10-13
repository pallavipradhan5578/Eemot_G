import 'package:gps/data/models/user_models.dart';

class RegisterResponseModel {
  final String token;
  final UserModel user;

  RegisterResponseModel({
    required this.token,
    required this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}