import 'package:dashboard_doctor_app/Services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final success =
          await AuthService.login(phone: phone, password: password);

      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("بيانات الدخول غير صحيحة"));
      }
    } catch (e) {
      emit(AuthFailure("حدث خطأ أثناء تسجيل الدخول"));
    }
  }
}