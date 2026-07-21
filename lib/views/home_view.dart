import 'package:flutter/material.dart';
import 'drugs_view.dart';
import 'pharmacies_view.dart';
import 'on_duty_view.dart';
import 'daily_info_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  final pages = const [
    DrugsView(),
    PharmaciesView(),
    OnDutyView(),
    DailyInfoView(),
  ];

  final titles = [
    "إدارة الأدوية",
    "إدارة الصيدليات",
    "إدارة المناوبات",
    "إدارة المعلومات الطبية",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[index])),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() => index = i),
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xffECF5FC),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.medical_services),
                label: Text("الأدوية"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.local_pharmacy),
                label: Text("الصيدليات"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.schedule),
                label: Text("المناوبة"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info_outline),
                label: Text("المعلومات"),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: pages[index]),
        ],
      ),
    );
  }
}