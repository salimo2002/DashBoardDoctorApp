import 'package:dashboard_doctor_app/cubits/OnDutyCubit/on_duty_cubit.dart';
import 'package:dashboard_doctor_app/cubits/OnDutyCubit/on_duty_state.dart';
import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_cubit.dart';
import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_state.dart';
import 'package:dashboard_doctor_app/models/pharmacy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnDutyView extends StatefulWidget {
  const OnDutyView({super.key});

  @override
  State<OnDutyView> createState() => _OnDutyViewState();
}

class _OnDutyViewState extends State<OnDutyView> {
  @override
  void initState() {
    super.initState();

    // ✅ تحميل المناوبات
    context.read<OnDutyCubit>().loadOnDuties();

    // ✅ تحميل الصيدليات (مهم جداً)
    context.read<PharmacyCubit>().loadPharmacies();
  }

  void _openDialog() {
    showDialog(context: context, builder: (_) => const AddOnDutyDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _openDialog,
            icon: const Icon(Icons.add),
            label: const Text("إضافة مناوبة"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<OnDutyCubit, OnDutyState>(
              builder: (context, state) {
                if (state is OnDutyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OnDutyError) {
                  return Center(child: Text(state.message));
                }

                if (state is OnDutyLoaded) {
                  if (state.onDuties.isEmpty) {
                    return const Center(child: Text("لا توجد مناوبات"));
                  }

                  return ListView.builder(
                    itemCount: state.onDuties.length,
                    itemBuilder: (context, index) {
                      final duty = state.onDuties[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                duty.pharmacyName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("التاريخ: ${duty.dutyDate}"),
                              Text("من ${duty.startTime} إلى ${duty.endTime}"),
                              const SizedBox(height: 10),
                              IconButton(
                                onPressed: () {
                                  context.read<OnDutyCubit>().deleteOnDuty(
                                    duty.id,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
class AddOnDutyDialog extends StatefulWidget {
  const AddOnDutyDialog({super.key});

  @override
  State<AddOnDutyDialog> createState() =>
      _AddOnDutyDialogState();
}

class _AddOnDutyDialogState extends State<AddOnDutyDialog> {
  PharmacyModel? selectedPharmacy;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => startTime = time);
    }
  }

  Future<void> _pickEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => endTime = time);
    }
  }

  void _save() {
    if (selectedPharmacy == null ||
        selectedDate == null ||
        startTime == null ||
        endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى تعبئة جميع الحقول")),
      );
      return;
    }

    final formattedDate =
        selectedDate!.toIso8601String().split("T")[0];

    final formattedStart =
        "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00";

    final formattedEnd =
        "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00";

    context.read<OnDutyCubit>().addOnDuty(
          pharmacyId: selectedPharmacy!.id,
          date: formattedDate,
          startTime: formattedStart,
          endTime: formattedEnd,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("إضافة مناوبة"),
      content: SizedBox(
        width: 500,
        child: BlocBuilder<PharmacyCubit, PharmacyState>(
          builder: (context, state) {
            if (state is PharmacyLoading) {
              return const Center(
                  child: CircularProgressIndicator());
            }

            if (state is PharmacyLoaded) {
              final pharmacies = state.pharmacies;

              if (pharmacies.isEmpty) {
                return const Text("لا توجد صيدليات متاحة");
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<PharmacyModel>(
                      items: pharmacies
                          .map(
                            (p) => DropdownMenuItem(
                              value: p,
                              child: Text(p.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() =>
                              selectedPharmacy = value),
                      decoration: const InputDecoration(
                        labelText: "اختر الصيدلية",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _pickDate,
                      child: const Text("اختيار التاريخ"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickStartTime,
                      child:
                          const Text("اختيار وقت البدء"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickEndTime,
                      child:
                          const Text("اختيار وقت الانتهاء"),
                    ),
                  ],
                ),
              );
            }

            return const Text("حدث خطأ");
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(onPressed: _save, child: const Text("حفظ")),
      ],
    );
  }
}