class DrugModel {
  final int id;
  final String name;
  final String? indications;
  final String? risks;
  final bool requiresPrescription;
  final bool isRare;

  DrugModel({
    required this.id,
    required this.name,
    this.indications,
    this.risks,
    required this.requiresPrescription,
    required this.isRare,
  });

  factory DrugModel.fromJson(Map<String, dynamic> j) => DrugModel(
        id: j['id'],
        name: j['name'],
        indications: j['indications'],
        risks: j['risks'],
        requiresPrescription: j['requires_prescription'] ?? false,
        isRare: j['is_rare'] ?? false,
      );
}