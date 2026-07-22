import 'package:dashboard_doctor_app/cubits/DrugCubit/drugs_cubit.dart';
import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DrugsCubit()..loadDrugs(),
        ),
        BlocProvider(
          create: (_) => PharmacyCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "لوحة تحكم المستشار الطبي",
        theme: appTheme,
        home: const LoginView(),
      ),
    );
  }
}
