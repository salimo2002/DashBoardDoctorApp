class DailyInfoModel {
  final int id;
  final String medicalInfo1;
  final String medicalInfo2;
  final String drugName;
  final String indication1;
  final String indication2;
  final String risks;
  final String dailyDate;

  DailyInfoModel({
    required this.id,
    required this.medicalInfo1,
    required this.medicalInfo2,
    required this.drugName,
    required this.indication1,
    required this.indication2,
    required this.risks,
    required this.dailyDate,
  });

  factory DailyInfoModel.fromJson(Map<String, dynamic> json) {
    return DailyInfoModel(
      id: json['id'],
      medicalInfo1: json['medical_info_1'] ?? '',
      medicalInfo2: json['medical_info_2'] ?? '',
      drugName: json['drug_name'] ?? '',
      indication1: json['indication_1'] ?? '',
      indication2: json['indication_2'] ?? '',
      risks: json['risks'] ?? '',
      dailyDate: json['daily_date'] ?? '',
    );
  }
}