class PharmacyModel {
  final int id;
  final String name;
  final String? address;
  final String? phoneNumber;
  final String? openingTime;
  final String? closingTime;
  final double? latitude;
  final double? longitude;

  PharmacyModel({
    required this.id,
    required this.name,
    this.address,
    this.phoneNumber,
    this.openingTime,
    this.closingTime,
    this.latitude,
    this.longitude,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
    );
  }
}