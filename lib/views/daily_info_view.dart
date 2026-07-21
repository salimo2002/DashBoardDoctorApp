import 'package:flutter/material.dart';

class DailyInfoView extends StatelessWidget {
  const DailyInfoView({super.key});

  void _openDialog(BuildContext context) =>
      showDialog(context: context, builder: (_) => const AddDailyInfoDialog());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () => _openDialog(context),
            icon: const Icon(Icons.add),
            label: const Text("إضافة معلومات اليوم"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "المعلومة الطبية",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1562AE),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("• يجب شرب الماء بكثرة."),
                      const Text("• لا تتجاوز الجرعة المحددة."),
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        "دواء اليوم",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1562AE),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "باراسيتامول",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "الاستطبابات:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text("• مسكن للألم."),
                      const Text("• خافض للحرارة."),
                      const SizedBox(height: 8),
                      const Text(
                        "الأضرار:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        "• اضطراب معدة.",
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddDailyInfoDialog extends StatelessWidget {
  const AddDailyInfoDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة معلومات يومية"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "المعلومة الطبية",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "المعلومة الأولى",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "المعلومة الثانية",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Text("دواء اليوم", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "اسم الدواء",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "الاستطباب الأول",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "الاستطباب الثاني",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "الأضرار",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("حفظ")),
      ],
    );
  }
}
