class AddVehicleRequest {
  final String vehicleNumber;
  final String ownersName;
  final String insuranceExpiryDate;
  final String chassisNumber;
  final String vehicleModel;
  final String vehicleColor;
  final String engineNumber;
  final String userId;
  final String createdById;
  final String vehicleType;
  final String status;
  final String activated;

  AddVehicleRequest({
    required this.vehicleNumber,
    required this.ownersName,
    required this.insuranceExpiryDate,
    required this.chassisNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.engineNumber,
    required this.userId,
    required this.createdById,
    required this.vehicleType,
    this.status = '1',
    this.activated = '1',
  });
}

class VehicleMedia {
  final String? id;
  final String? name;
  final String? fileName;
  final String? url;
  final String? thumbnail;
  final String? preview;

  VehicleMedia({
    this.id,
    this.name,
    this.fileName,
    this.url,
    this.thumbnail,
    this.preview,
  });

  factory VehicleMedia.fromJson(Map<String, dynamic> json) {
    return VehicleMedia(
      id: json['id']?.toString(),
      name: json['name'],
      fileName: json['file_name'],
      url: json['url'] ?? json['original_url'],
      thumbnail: json['thumbnail'],
      preview: json['preview'] ?? json['preview_url'],
    );
  }
}

class AddVehicleResponse {
  final bool status;
  final String message;
  final int? vehicleId;
  final String? vehicleNumber;
  final Map<String, dynamic>? media;

  AddVehicleResponse({
    required this.status,
    required this.message,
    this.vehicleId,
    this.vehicleNumber,
    this.media,
  });

  factory AddVehicleResponse.fromJson(Map<String, dynamic> json) {
    return AddVehicleResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      vehicleId: json['vehicle_id'],
      vehicleNumber: json['vehicle_number'],
      media: json['media'],
    );
  }
}