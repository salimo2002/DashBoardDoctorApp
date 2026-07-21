import 'package:supabase_flutter/supabase_flutter.dart';

class DailyInfoService {
  static final _db = Supabase.instance.client;

  static Future<List> getAll() async {
    return await _db.from('daily_information').select().order('daily_date', ascending: false);
  }

  static Future<void> add(Map<String, dynamic> data) async {
    await _db.from('daily_information').insert(data);
  }

  static Future<void> delete(int id) async {
    await _db.from('daily_information').delete().eq('id', id);
  }
}