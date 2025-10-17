class VehicleDetailsModel {
  final String? vehicleNumber;
  final String? productModel; // <-- add this
  final dynamic status;
  final String? activationDate;
  final String? warranty;
  final String? subscription;
  final String? amc;
  final String? kycStatus;
  final String? appUrl;

  VehicleDetailsModel({
    this.vehicleNumber,
    this.productModel,
    this.status,
    this.activationDate,
    this.warranty,
    this.subscription,
    this.amc,
    this.kycStatus,
    this.appUrl,
  });

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    return VehicleDetailsModel(
      vehicleNumber: json['vehicle_number'],
      productModel: json['product_model'], // <-- parse here
      status: json['status'],
      activationDate: json['activation_date'],
      warranty: json['warranty'],
      subscription: json['subscription'],
      amc: json['amc'],
      kycStatus: json['kyc_status'],
      appUrl: json['app_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_number': vehicleNumber,
      'product_model': productModel,
      'status': status,
      'activation_date': activationDate,
      'warranty': warranty,
      'subscription': subscription,
      'amc': amc,
      'kyc_status': kycStatus,
      'app_url': appUrl,
    };
  }
}
