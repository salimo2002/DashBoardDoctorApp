import 'package:flutter/material.dart';

class DrugsView extends StatefulWidget {
  const DrugsView({super.key});
  @override
  State<DrugsView> createState() => _DrugsViewState();
}

class _DrugsViewState extends State<DrugsView> {
  void _openAddDialog() =>
      showDialog(context: context, builder: (_) => const AddDrugDialog());
  void _openEditDialog() =>
      showDialog(context: context, builder: (_) => const AddDrugDialog());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _openAddDialog,
            icon: const Icon(Icons.add),
            label: const Text("إضافة دواء"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.medical_services,
                            color: Color(0xff1562AE),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "باراسيتامول",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "مفقود",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text("الاستطبابات: مسكن للألم"),
                      const Text("الأضرار: اضطراب معدة"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _openEditDialog,
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

class AddDrugDialog extends StatefulWidget {
  const AddDrugDialog({super.key});
  @override
  State<AddDrugDialog> createState() => _AddDrugDialogState();
}

class _AddDrugDialogState extends State<AddDrugDialog> {
  bool requiresPrescription = false;
  bool isMissing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة / تعديل دواء"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: "اسم الدواء",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "الاستطبابات",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "الأضرار",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text("يحتاج إلى وصفة طبية"),
                value: requiresPrescription,
                onChanged: (v) =>
                    setState(() => requiresPrescription = v ?? false),
              ),
              CheckboxListTile(
                title: const Text("دواء مفقود"),
                value: isMissing,
                onChanged: (v) => setState(() => isMissing = v ?? false),
              ),
              if (isMissing) ...[
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  "بيانات الصيدلية المتوفرة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "اسم الصيدلية",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "رقم الصيدلية",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
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
