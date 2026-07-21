import 'package:flutter/material.dart';

class PharmaciesView extends StatelessWidget {
  const PharmaciesView({super.key});
  void _openDialog(BuildContext context) => showDialog(context: context, builder: (_) => const AddPharmacyDialog());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(onPressed: () => _openDialog(context), icon: const Icon(Icons.add), label: const Text("إضافة صيدلية")),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [const Icon(Icons.local_pharmacy, color: Color(0xff1562AE)), const SizedBox(width: 8), const Text("صيدلية الاندلس", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
                      const SizedBox(height: 8),
                      const Text("الهاتف: 0312111070"),
                      const Text("العنوان: شارع الحضارة"),
                      const Text("الموقع: 34.71 , 36.71"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(onPressed: () => _openDialog(context), icon: const Icon(Icons.edit)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red)),
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

class AddPharmacyDialog extends StatelessWidget {
  const AddPharmacyDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة / تعديل صيدلية"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(children: const [
            TextField(decoration: InputDecoration(labelText: "اسم الصيدلية", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "رقم الهاتف", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "العنوان", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "وقت الفتح (مثال 09:00)", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "وقت الإغلاق (مثال 19:00)", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "خط العرض (Latitude)", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "خط الطول (Longitude)", border: OutlineInputBorder())),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
        ElevatedButton(onPressed: () {}, child: const Text("حفظ")),
      ],
    );
  }
}