import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(DashBoardDoctorApp());
}

class DashBoardDoctorApp extends StatelessWidget {
  const DashBoardDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold());
  }
}
