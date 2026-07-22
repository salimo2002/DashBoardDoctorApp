import 'package:dashboard_doctor_app/cubits/AuthCubit/auth_cubit.dart';
import 'package:dashboard_doctor_app/cubits/DailyInfoCubit/daily_info_cubit.dart';
import 'package:dashboard_doctor_app/cubits/DrugCubit/drugs_cubit.dart';
import 'package:dashboard_doctor_app/cubits/OnDutyCubit/on_duty_cubit.dart';
import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_cubit.dart';
import 'package:dashboard_doctor_app/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'keys/supabase_keys.dart';
import 'theme/theme.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800), 
    minimumSize: Size(1000, 650), 
    center: true,
    title: "لوحة تحكم المستشار الطبي",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
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
        BlocProvider(
          create: (_) => OnDutyCubit(),
        ),
        BlocProvider(
          create: (_) => DailyInfoCubit(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "لوحة تحكم المستشار الطبي",
        theme: appTheme,
        home: const SplashView(),
      ),
    );
  }
}
