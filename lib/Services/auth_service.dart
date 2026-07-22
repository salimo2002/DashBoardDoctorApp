import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _db = Supabase.instance.client;

  static Future<bool> login({
    required String phone,
    required String password,
  }) async {
    final response = await _db
        .from('app_users')
        .select()
        .eq('phone_number', phone)
        .eq('password', password)
        .maybeSingle();

    return response != null;
  }
}