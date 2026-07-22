import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_cubit.dart';
import 'package:dashboard_doctor_app/cubits/PharmacyCubit/pharmacy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pharmacy_model.dart';

class PharmaciesView extends StatefulWidget {
  const PharmaciesView({super.key});

  @override
  State<PharmaciesView> createState() => _PharmaciesViewState();
}

class _PharmaciesViewState extends State<PharmaciesView> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<PharmacyCubit>().loadPharmacies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openDialog([PharmacyModel? pharmacy]) {
    showDialog(
      context: context,
      builder: (_) => AddPharmacyDialog(pharmacy: pharmacy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _openDialog(),
                icon: const Icon(Icons.add),
                label: const Text("إضافة صيدلية"),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "ابحث عن صيدلية...",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<PharmacyCubit, PharmacyState>(
              builder: (context, state) {
                if (state is PharmacyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PharmacyError) {
                  return Center(child: Text(state.message));
                }

                if (state is PharmacyLoaded) {
                  final filtered = state.pharmacies
                      .where((p) => p.name.toLowerCase().contains(searchQuery))
                      .toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text("لا توجد نتائج"));
                  }

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final pharmacy = filtered[index];
                      return _buildCard(pharmacy);
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

  Widget _buildCard(PharmacyModel pharmacy) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_pharmacy, color: Color(0xff1562AE)),
                const SizedBox(width: 8),
                Text(
                  pharmacy.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("الهاتف: ${pharmacy.phoneNumber ?? ''}"),
            Text("العنوان: ${pharmacy.address ?? ''}"),
            Text(
              "الموقع: ${pharmacy.latitude ?? ''}, ${pharmacy.longitude ?? ''}",
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () => _openDialog(pharmacy),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    context.read<PharmacyCubit>().deletePharmacy(pharmacy.id);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddPharmacyDialog extends StatefulWidget {
  final PharmacyModel? pharmacy;

  const AddPharmacyDialog({super.key, this.pharmacy});

  @override
  State<AddPharmacyDialog> createState() => _AddPharmacyDialogState();
}

class _AddPharmacyDialogState extends State<AddPharmacyDialog> {
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController latitude;
  late TextEditingController longitude;

  TimeOfDay? openingTime;
  TimeOfDay? closingTime;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.pharmacy?.name ?? "");
    phone = TextEditingController(text: widget.pharmacy?.phoneNumber ?? "");
    address = TextEditingController(text: widget.pharmacy?.address ?? "");
    latitude = TextEditingController(
      text: widget.pharmacy?.latitude?.toString() ?? "",
    );
    longitude = TextEditingController(
      text: widget.pharmacy?.longitude?.toString() ?? "",
    );
  }

  Future<void> _pickOpeningTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => openingTime = picked);
    }
  }

  Future<void> _pickClosingTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => closingTime = picked);
    }
  }

  void _save() {
    final cubit = context.read<PharmacyCubit>();

    final formattedOpening = openingTime != null
        ? "${openingTime!.hour.toString().padLeft(2, '0')}:${openingTime!.minute.toString().padLeft(2, '0')}:00"
        : null;

    final formattedClosing = closingTime != null
        ? "${closingTime!.hour.toString().padLeft(2, '0')}:${closingTime!.minute.toString().padLeft(2, '0')}:00"
        : null;

    if (widget.pharmacy == null) {
      cubit.addPharmacy(
        name: name.text.trim(),
        address: address.text.trim(),
        phoneNumber: phone.text.trim(),
        openingTime: formattedOpening,
        closingTime: formattedClosing,
        latitude: double.tryParse(latitude.text),
        longitude: double.tryParse(longitude.text),
      );
    } else {
      cubit.updatePharmacy(
        id: widget.pharmacy!.id,
        name: name.text.trim(),
        address: address.text.trim(),
        phoneNumber: phone.text.trim(),
        openingTime: formattedOpening,
        closingTime: formattedClosing,
        latitude: double.tryParse(latitude.text),
        longitude: double.tryParse(longitude.text),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pharmacy == null ? "إضافة صيدلية" : "تعديل صيدلية"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: "اسم الصيدلية",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phone,
                decoration: const InputDecoration(
                  labelText: "رقم الهاتف",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  labelText: "العنوان",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      openingTime == null
                          ? "لم يتم اختيار وقت الفتح"
                          : "وقت الفتح: ${openingTime!.format(context)}",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickOpeningTime,
                    child: const Text("اختيار وقت الفتح"),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      closingTime == null
                          ? "لم يتم اختيار وقت الإغلاق"
                          : "وقت الإغلاق: ${closingTime!.format(context)}",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickClosingTime,
                    child: const Text("اختيار وقت الإغلاق"),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              TextField(
                controller: latitude,
                decoration: const InputDecoration(
                  labelText: "Latitude",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: longitude,
                decoration: const InputDecoration(
                  labelText: "Longitude",
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
        ElevatedButton(onPressed: _save, child: const Text("حفظ")),
      ],
    );
  }
}
