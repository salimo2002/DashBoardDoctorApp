import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/drug_model.dart';

class DrugService {
  static final _db = Supabase.instance.client;

  static Future<List<DrugModel>> getAll() async {
    final res = await _db.from('drugs').select().order('name');
    return res.map((e) => DrugModel.fromJson(e)).toList();
  }

  static Future<void> add({
    required String name,
    String? indications,
    String? risks,
    bool requiresPrescription = false,
    bool isRare = false,
    List<Map<String, String>>? missingPharmacies,
  }) async {
    final inserted = await _db.from('drugs').insert({
      'name': name,
      'indications': indications,
      'risks': risks,
      'requires_prescription': requiresPrescription,
      'is_rare': isRare,
    }).select().single();

    if (isRare && missingPharmacies != null) {
      for (var p in missingPharmacies) {
        await _db.from('missing_drugs').insert({
          'drug_id': inserted['id'],
          'pharmacy_name': p['name'],
          'pharmacy_phone': p['phone'],
        });
      }
    }
  }

  static Future<void> update(int id, Map<String, dynamic> data) async {
    await _db.from('drugs').update(data).eq('id', id);
  }

  static Future<void> delete(int id) async {
    await _db.from('drugs').delete().eq('id', id);
  }
}