import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/daily_info_model.dart';

class DailyInfoService {
  static final SupabaseClient _db = Supabase.instance.client;

  /// ✅ جلب جميع المعلومات مرتبة حسب التاريخ
  static Future<List<DailyInfoModel>> getAll() async {
    final response = await _db
        .from('daily_information')
        .select()
        .order('daily_date', ascending: false);

    return response
        .map((e) => DailyInfoModel.fromJson(e))
        .toList();
  }

  /// ✅ إضافة معلومة بتاريخ محدد
  static Future<void> add({
    required String medicalInfo1,
    required String medicalInfo2,
    required String drugName,
    required String indication1,
    required String indication2,
    required String risks,
    required String date, // ✅ مهم جداً
  }) async {
    await _db.from('daily_information').insert({
      'medical_info_1': medicalInfo1,
      'medical_info_2': medicalInfo2,
      'drug_name': drugName,
      'indication_1': indication1,
      'indication_2': indication2,
      'risks': risks,
      'daily_date': date, // ✅ إضافة التاريخ
    });
  }

  /// ✅ تعديل معلومة مع تحديث التاريخ
  static Future<void> update({
    required int id,
    required String medicalInfo1,
    required String medicalInfo2,
    required String drugName,
    required String indication1,
    required String indication2,
    required String risks,
    required String date, // ✅ مهم
  }) async {
    await _db.from('daily_information').update({
      'medical_info_1': medicalInfo1,
      'medical_info_2': medicalInfo2,
      'drug_name': drugName,
      'indication_1': indication1,
      'indication_2': indication2,
      'risks': risks,
      'daily_date': date, // ✅ تحديث التاريخ
    }).eq('id', id);
  }

  /// ✅ حذف معلومة
  static Future<void> delete(int id) async {
    await _db.from('daily_information').delete().eq('id', id);
  }
}