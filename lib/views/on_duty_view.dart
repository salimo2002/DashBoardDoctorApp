import 'package:flutter/material.dart';

class OnDutyView extends StatefulWidget {
  const OnDutyView({super.key});
  @override
  State<OnDutyView> createState() => _OnDutyViewState();
}

class _OnDutyViewState extends State<OnDutyView> {
  void _openDialog() => showDialog(context: context, builder: (_) => const AddOnDutyDialog());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(onPressed: _openDialog, icon: const Icon(Icons.add), label: const Text("إضافة مناوبة")),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("صيدلية الزين", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("التاريخ: 2026-07-20"),
                      Text("من 09:00 إلى 01:00"),
                      SizedBox(height: 10),
                      Align(alignment: Alignment.centerLeft, child: IconButton(onPressed: null, icon: Icon(Icons.delete, color: Colors.red))),
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

class AddOnDutyDialog extends StatefulWidget {
  const AddOnDutyDialog({super.key});
  @override
  State<AddOnDutyDialog> createState() => _AddOnDutyDialogState();
}

class _AddOnDutyDialogState extends State<AddOnDutyDialog> {
  DateTime? selectedDate;
  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030), initialDate: DateTime.now());
    if (date != null) setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة مناوبة"),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(decoration: InputDecoration(labelText: "اسم الصيدلية", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: Text(selectedDate == null ? "لم يتم اختيار تاريخ" : selectedDate.toString().split(" ")[0])),
              ElevatedButton(onPressed: _pickDate, child: const Text("اختيار التاريخ")),
            ]),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: "وقت البدء (مثال 09:00)", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: "وقت الانتهاء (مثال 01:00)", border: OutlineInputBorder())),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
        ElevatedButton(onPressed: () {}, child: const Text("حفظ")),
      ],
    );
  }
}