import 'package:dashboard_doctor_app/cubits/AuthCubit/auth_cubit.dart';
import 'package:dashboard_doctor_app/cubits/AuthCubit/auth_state.dart';
import 'package:dashboard_doctor_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeView(),
              ),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffEBF4FB),
                  Color(0xffD1E6F9),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Container(
                width: 420,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: Colors.black
                          .withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/app_icon.png',
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "لوحة تحكم المستشار الطبي",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller:
                          phoneController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "رقم الهاتف",
                        border:
                            OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller:
                          passwordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "كلمة المرور",
                        border:
                            OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton(
                        onPressed:
                            state is AuthLoading
                                ? null
                                : () {
                                    context
                                        .read<
                                            AuthCubit>()
                                        .login(
                                          phone:
                                              phoneController
                                                  .text
                                                  .trim(),
                                          password:
                                              passwordController
                                                  .text
                                                  .trim(),
                                        );
                                  },
                        child: state
                                is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "تسجيل الدخول"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}