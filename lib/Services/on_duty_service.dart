import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/on_duty_model.dart';

class OnDutyService {
  static final SupabaseClient _db = Supabase.instance.client;

  static Future<List<OnDutyModel>> getAll() async {
    final response = await _db
        .from('on_duty_pharmacies')
        .select('*, pharmacies(name)')
        .order('duty_date', ascending: false);

    return response
        .map((e) => OnDutyModel.fromJson(e))
        .toList();
  }

  static Future<void> add({
    required int pharmacyId,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    await _db.from('on_duty_pharmacies').insert({
      'pharmacy_id': pharmacyId,
      'duty_date': date,
      'start_time': startTime,
      'end_time': endTime,
    });
  }

  static Future<void> delete(int id) async {
    await _db.from('on_duty_pharmacies').delete().eq('id', id);
  }
}