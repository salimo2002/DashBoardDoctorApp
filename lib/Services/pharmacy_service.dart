import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pharmacy_model.dart';

class PharmacyService {
  static final SupabaseClient _db = Supabase.instance.client;

  static Future<List<PharmacyModel>> getAll() async {
    final response =
        await _db.from('pharmacies').select().order('name');

    return response
        .map((e) => PharmacyModel.fromJson(e))
        .toList();
  }

  static Future<void> add({
    required String name,
    String? address,
    String? phoneNumber,
    String? openingTime,
    String? closingTime,
    double? latitude,
    double? longitude,
  }) async {
    await _db.from('pharmacies').insert({
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  static Future<void> update({
    required int id,
    required String name,
    String? address,
    String? phoneNumber,
    String? openingTime,
    String? closingTime,
    double? latitude, 
    double? longitude,
  }) async {
    await _db.from('pharmacies').update({
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'latitude': latitude,
      'longitude': longitude,
    }).eq('id', id);
  }

  static Future<void> delete(int id) async {
    await _db.from('pharmacies').delete().eq('id', id);
  }
}