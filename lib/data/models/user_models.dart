class UserModel {
  final int id;
  final String name;
  final String? companyName;
  final String email;
  final String? gstNumber;
  final String mobileNumber;
  final String? whatsappNumber;
  final String? pinCode;
  final String? fullAddress;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.name,
    this.companyName,
    required this.email,
    this.gstNumber,
    required this.mobileNumber,
    this.whatsappNumber,
    this.pinCode,
    this.fullAddress,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      companyName: json['company_name'],
      email: json['email'],
      gstNumber: json['gst_number'],
      mobileNumber: json['mobile_number'] ?? '',
      whatsappNumber: json['whatsapp_number'],
      pinCode: json['pin_code'],
      fullAddress: json['full_address'],
      roles: List<String>.from(json['roles']),
    );
  }
}
