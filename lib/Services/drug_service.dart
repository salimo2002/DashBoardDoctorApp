import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/drug_model.dart';

class DrugService {
  static final SupabaseClient _db = Supabase.instance.client;

  /// ✅ جلب جميع الأدوية مع الصيدليات
  static Future<List<DrugModel>> getAll() async {
    final response = await _db
        .from('drugs')
        .select('*, missing_drugs(*)')
        .order('name');

    return response.map((e) => DrugModel.fromJson(e)).toList();
  }

  /// ✅ إضافة دواء
  static Future<void> add({
    required String name,
    String? indications,
    String? risks,
    required bool requiresPrescription,
    required bool isRare,
    List<Map<String, String>>? missingPharmacies,
  }) async {
    final inserted = await _db
        .from('drugs')
        .insert({
          'name': name,
          'indications': indications,
          'risks': risks,
          'requires_prescription': requiresPrescription,
          'is_rare': isRare,
        })
        .select()
        .single();

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

  /// ✅ تحديث دواء
  static Future<void> update({
    required int id,
    required String name,
    String? indications,
    String? risks,
    required bool requiresPrescription,
    required bool isRare,
    List<Map<String, String>>? missingPharmacies,
  }) async {
    await _db.from('drugs').update({
      'name': name,
      'indications': indications,
      'risks': risks,
      'requires_prescription': requiresPrescription,
      'is_rare': isRare,
    }).eq('id', id);

    await _db.from('missing_drugs').delete().eq('drug_id', id);

    if (isRare && missingPharmacies != null) {
      for (var p in missingPharmacies) {
        await _db.from('missing_drugs').insert({
          'drug_id': id,
          'pharmacy_name': p['name'],
          'pharmacy_phone': p['phone'],
        });
      }
    }
  }

  /// ✅ حذف دواء
  static Future<void> delete(int id) async {
    await _db.from('missing_drugs').delete().eq('drug_id', id);
    await _db.from('drugs').delete().eq('id', id);
  }
}