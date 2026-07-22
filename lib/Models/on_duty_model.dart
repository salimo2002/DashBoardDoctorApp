class OnDutyModel {
  final int id;
  final String dutyDate;
  final String startTime;
  final String endTime;
  final int pharmacyId;
  final String pharmacyName;

  OnDutyModel({
    required this.id,
    required this.dutyDate,
    required this.startTime,
    required this.endTime,
    required this.pharmacyId,
    required this.pharmacyName,
  });

  factory OnDutyModel.fromJson(Map<String, dynamic> json) {
    return OnDutyModel(
      id: json['id'],
      dutyDate: json['duty_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      pharmacyId: json['pharmacy_id'],
      pharmacyName: json['pharmacies']['name'],
    );
  }
}