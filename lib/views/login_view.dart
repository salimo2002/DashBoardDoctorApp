import 'package:dashboard_doctor_app/views/home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffEBF4FB), Color(0xffD1E6F9), Colors.white],
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
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/app_icon.png', width: 150),
                const SizedBox(height: 10),
                const Text(
                  "لوحة تحكم المستشار الطبي",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "رقم الهاتف",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "كلمة المرور",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                    child: const Text("تسجيل الدخول"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
