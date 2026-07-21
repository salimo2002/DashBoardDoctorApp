import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final _db = Supabase.instance.client;

  static Future<bool> login(String phone, String password) async {
    final res = await _db
        .from('app_users')
        .select()
        .eq('phone_number', phone)
        .eq('password', password)
        .maybeSingle();

    return res != null;
  }
}