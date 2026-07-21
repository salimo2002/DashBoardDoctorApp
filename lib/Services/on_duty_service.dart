import 'package:supabase_flutter/supabase_flutter.dart';

class OnDutyService {
  static final _db = Supabase.instance.client;

  static Future<void> add({
    required int pharmacyId,
    required String start,
    required String end,
    required String date,
  }) async {
    await _db.from('on_duty_pharmacies').insert({
      'pharmacy_id': pharmacyId,
      'start_time': start,
      'end_time': end,
      'duty_date': date,
    });
  }

  static Future<List> getAll() async {
    return await _db
        .from('on_duty_pharmacies')
        .select('*, pharmacies(*)')
        .order('duty_date', ascending: false);
  }

  static Future<void> delete(int id) async {
    await _db.from('on_duty_pharmacies').delete().eq('id', id);
  }
}