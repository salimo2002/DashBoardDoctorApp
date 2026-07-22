import 'package:dashboard_doctor_app/cubits/DailyInfoCubit/daily_info_cubit.dart';
import 'package:dashboard_doctor_app/cubits/DailyInfoCubit/daily_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/daily_info_model.dart';

class DailyInfoView extends StatefulWidget {
  const DailyInfoView({super.key});

  @override
  State<DailyInfoView> createState() => _DailyInfoViewState();
}

class _DailyInfoViewState extends State<DailyInfoView> {
  @override
  void initState() {
    super.initState();
    context.read<DailyInfoCubit>().loadDailyInfo();
  }

  void _openDialog([DailyInfoModel? item]) {
    showDialog(
      context: context,
      builder: (_) => AddDailyInfoDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () => _openDialog(),
            icon: const Icon(Icons.add),
            label: const Text("إضافة معلومات اليوم"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<DailyInfoCubit, DailyInfoState>(
              builder: (context, state) {
                if (state is DailyInfoLoading) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (state is DailyInfoError) {
                  return Center(child: Text(state.message));
                }

                if (state is DailyInfoLoaded) {
                  if (state.items.isEmpty) {
                    return const Center(child: Text("لا توجد معلومات"));
                  }

                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "التاريخ: ${item.dailyDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),

                              const Text(
                                "المعلومة الطبية",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1562AE),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("• ${item.medicalInfo1}"),
                              Text("• ${item.medicalInfo2}"),

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
                              const SizedBox(height: 5),

                              Text(
                                item.drugName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 5),

                              Text("• ${item.indication1}"),
                              Text("• ${item.indication2}"),

                              const SizedBox(height: 5),

                              Text(
                                item.risks,
                                style: const TextStyle(
                                    color: Colors.red),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _openDialog(item),
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<
                                              DailyInfoCubit>()
                                          .deleteDailyInfo(
                                              item.id);
                                    },
                                    icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
class AddDailyInfoDialog extends StatefulWidget {
  final DailyInfoModel? item;

  const AddDailyInfoDialog({super.key, this.item});

  @override
  State<AddDailyInfoDialog> createState() =>
      _AddDailyInfoDialogState();
}

class _AddDailyInfoDialogState
    extends State<AddDailyInfoDialog> {
  late TextEditingController medicalInfo1;
  late TextEditingController medicalInfo2;
  late TextEditingController drugName;
  late TextEditingController indication1;
  late TextEditingController indication2;
  late TextEditingController risks;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    medicalInfo1 = TextEditingController(
        text: widget.item?.medicalInfo1 ?? "");
    medicalInfo2 = TextEditingController(
        text: widget.item?.medicalInfo2 ?? "");
    drugName = TextEditingController(
        text: widget.item?.drugName ?? "");
    indication1 = TextEditingController(
        text: widget.item?.indication1 ?? "");
    indication2 = TextEditingController(
        text: widget.item?.indication2 ?? "");
    risks = TextEditingController(
        text: widget.item?.risks ?? "");

    if (widget.item != null) {
      selectedDate =
          DateTime.parse(widget.item!.dailyDate);
    }
  }

  @override
  void dispose() {
    medicalInfo1.dispose();
    medicalInfo2.dispose();
    drugName.dispose();
    indication1.dispose();
    indication2.dispose();
    risks.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _save() {
    final formattedDate =
        selectedDate.toIso8601String().split("T")[0];

    if (widget.item == null) {
      context.read<DailyInfoCubit>().addDailyInfo(
            medicalInfo1: medicalInfo1.text.trim(),
            medicalInfo2: medicalInfo2.text.trim(),
            drugName: drugName.text.trim(),
            indication1: indication1.text.trim(),
            indication2: indication2.text.trim(),
            risks: risks.text.trim(),
            date: formattedDate,
          );
    } else {
      context.read<DailyInfoCubit>().updateDailyInfo(
            id: widget.item!.id,
            medicalInfo1: medicalInfo1.text.trim(),
            medicalInfo2: medicalInfo2.text.trim(),
            drugName: drugName.text.trim(),
            indication1: indication1.text.trim(),
            indication2: indication2.text.trim(),
            risks: risks.text.trim(),
            date: formattedDate,
          );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null
          ? "إضافة معلومات يومية"
          : "تعديل معلومات يومية"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(
                    "اختيار التاريخ: ${selectedDate.toIso8601String().split("T")[0]}"),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: medicalInfo1,
                decoration: const InputDecoration(
                  labelText: "المعلومة الأولى",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: medicalInfo2,
                decoration: const InputDecoration(
                  labelText: "المعلومة الثانية",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 10),
              TextField(
                controller: drugName,
                decoration: const InputDecoration(
                  labelText: "اسم الدواء",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: indication1,
                decoration: const InputDecoration(
                  labelText: "الاستطباب الأول",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: indication2,
                decoration: const InputDecoration(
                  labelText: "الاستطباب الثاني",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: risks,
                maxLines: 3,
                decoration: const InputDecoration(
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
          onPressed: () =>
              Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text("حفظ"),
        ),
      ],
    );
  }
}