class VehicleTypeModel {
  final int id;
  final String vehicleType;
  final String iconUrl;

  VehicleTypeModel({
    required this.id,
    required this.vehicleType,
    required this.iconUrl,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: json['id'],
      vehicleType: json['vehicle_type'],
      iconUrl: json['icon_url'],
    );
  }
}
