import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pharmacy_model.dart';

class PharmacyService {
  static final _db = Supabase.instance.client;

  static Future<List<PharmacyModel>> getAll() async {
    final res = await _db.from('pharmacies').select().order('name');
    return res.map((e) => PharmacyModel.fromJson(e)).toList();
  }

  static Future<void> add(Map<String, dynamic> data) async {
    await _db.from('pharmacies').insert(data);
  }

  static Future<void> update(int id, Map<String, dynamic> data) async {
    await _db.from('pharmacies').update(data).eq('id', id);
  }

  static Future<void> delete(int id) async {
    await _db.from('pharmacies').delete().eq('id', id);
  }
}