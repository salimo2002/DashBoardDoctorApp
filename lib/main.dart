import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'keys/supabase_keys.dart';
import 'theme/theme.dart';
import 'views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseKeys.url,
    anonKey: SupabaseKeys.anonKey,
  );
  runApp(const DashBoardDoctorApp());
}

class DashBoardDoctorApp extends StatelessWidget {
  const DashBoardDoctorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "لوحة تحكم المستشار الطبي",
      theme: appTheme,
      home: const LoginView(),
    );
  }
}