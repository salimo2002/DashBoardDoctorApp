class PharmacyModel {
  final int id;
  final String name;
  final String? address;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final String? openingTime;
  final String? closingTime;

  PharmacyModel({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.openingTime,
    this.closingTime,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> j) => PharmacyModel(
        id: j['id'],
        name: j['name'],
        address: j['address'],
        phone: j['phone_number'],
        latitude: (j['latitude'] as num?)?.toDouble(),
        longitude: (j['longitude'] as num?)?.toDouble(),
        openingTime: j['opening_time'],
        closingTime: j['closing_time'],
      );
}