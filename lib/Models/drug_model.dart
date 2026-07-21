class MissingPharmacyModel {
  final int id;
  final String pharmacyName;
  final String pharmacyPhone;

  MissingPharmacyModel({
    required this.id,
    required this.pharmacyName,
    required this.pharmacyPhone,
  });

  factory MissingPharmacyModel.fromJson(Map<String, dynamic> json) {
    return MissingPharmacyModel(
      id: json['id'],
      pharmacyName: json['pharmacy_name'] ?? '',
      pharmacyPhone: json['pharmacy_phone'] ?? '',
    );
  }
}

class DrugModel {
  final int id;
  final String name;
  final String? indications;
  final String? risks;
  final bool requiresPrescription;
  final bool isRare;
  final List<MissingPharmacyModel> pharmacies;

  DrugModel({
    required this.id,
    required this.name,
    this.indications,
    this.risks,
    required this.requiresPrescription,
    required this.isRare,
    required this.pharmacies,
  });

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    List<MissingPharmacyModel> pharmacyList = [];

    if (json['missing_drugs'] != null) {
      pharmacyList = (json['missing_drugs'] as List)
          .map((e) => MissingPharmacyModel.fromJson(e))
          .toList();
    }

    return DrugModel(
      id: json['id'],
      name: json['name'],
      indications: json['indications'],
      risks: json['risks'],
      requiresPrescription: json['requires_prescription'] ?? false,
      isRare: json['is_rare'] ?? false,
      pharmacies: pharmacyList,
    );
  }
}