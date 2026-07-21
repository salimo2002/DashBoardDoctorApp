import 'package:dashboard_doctor_app/cubits/DrugCubit/drugs_cubit.dart';
import 'package:dashboard_doctor_app/cubits/DrugCubit/drugs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/drug_model.dart';

class DrugsView extends StatefulWidget {
  const DrugsView({super.key});

  @override
  State<DrugsView> createState() => _DrugsViewState();
}

class _DrugsViewState extends State<DrugsView> {
  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        const AddDrugDialog(),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("إضافة دواء"),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "ابحث عن دواء...",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery =
                          value.trim().toLowerCase();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                BlocBuilder<DrugsCubit, DrugsState>(
              builder: (context, state) {
                if (state is DrugsLoading) {
                  return const Center(
                      child:
                          CircularProgressIndicator());
                }

                if (state is DrugsError) {
                  return Center(
                      child:
                          Text("خطأ: ${state.message}"));
                }

                if (state is DrugsLoaded) {
                  final drugs = state.drugs;

                  final filteredDrugs =
                      drugs.where((drug) {
                    return drug.name
                        .toLowerCase()
                        .contains(searchQuery);
                  }).toList();

                  if (filteredDrugs.isEmpty) {
                    return const Center(
                        child: Text("لا توجد نتائج"));
                  }

                  return ListView.builder(
                    itemCount:
                        filteredDrugs.length,
                    itemBuilder: (context,
                        index) {
                      final drug =
                          filteredDrugs[index];
                      return _buildDrugCard(
                          context, drug);
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

  Widget _buildDrugCard(
      BuildContext context, DrugModel drug) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                    Icons.medical_services,
                    color: Color(0xff1562AE)),
                const SizedBox(width: 8),
                Text(
                  drug.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold),
                ),
                const Spacer(),
                if (drug.isRare)
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.red.shade100,
                      borderRadius:
                          BorderRadius
                              .circular(6),
                    ),
                    child: const Text(
                      "مفقود",
                      style: TextStyle(
                          color: Colors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (drug.indications != null)
              Text(
                  "الاستطبابات: ${drug.indications}"),
            if (drug.risks != null)
              Text(
                "الأضرار: ${drug.risks}",
                style: const TextStyle(
                    color: Colors.red),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          AddDrugDialog(
                              drug: drug),
                    );
                  },
                  icon:
                      const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<
                            DrugsCubit>()
                        .deleteDrug(
                            drug.id);
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
  }
}
class AddDrugDialog extends StatefulWidget {
  final DrugModel? drug;

  const AddDrugDialog({super.key, this.drug});

  @override
  State<AddDrugDialog> createState() => _AddDrugDialogState();
}

class _AddDrugDialogState extends State<AddDrugDialog> {
  late TextEditingController name;
  late TextEditingController indications;
  late TextEditingController risks;
  late TextEditingController pharmacyName;
  late TextEditingController pharmacyPhone;

  bool requiresPrescription = false;
  bool isMissing = false;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.drug?.name ?? "");
    indications = TextEditingController(text: widget.drug?.indications ?? "");
    risks = TextEditingController(text: widget.drug?.risks ?? "");
    pharmacyName = TextEditingController();
    pharmacyPhone = TextEditingController();

    requiresPrescription = widget.drug?.requiresPrescription ?? false;
    isMissing = widget.drug?.isRare ?? false;
  }

  void _save() {
    final cubit = context.read<DrugsCubit>();

    if (widget.drug == null) {
      cubit.addDrug(
        name: name.text.trim(),
        indications: indications.text.trim(),
        risks: risks.text.trim(),
        requiresPrescription: requiresPrescription,
        isRare: isMissing,
        pharmacyName: isMissing ? pharmacyName.text.trim() : null,
        pharmacyPhone: isMissing ? pharmacyPhone.text.trim() : null,
      );
    } else {
      cubit.updateDrug(
        id: widget.drug!.id,
        name: name.text.trim(),
        indications: indications.text.trim(),
        risks: risks.text.trim(),
        requiresPrescription: requiresPrescription,
        isRare: isMissing,
        pharmacyName: isMissing ? pharmacyName.text.trim() : null,
        pharmacyPhone: isMissing ? pharmacyPhone.text.trim() : null,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.drug == null ? "إضافة دواء" : "تعديل دواء"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: "اسم الدواء",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: indications,
                decoration: const InputDecoration(
                  labelText: "الاستطبابات",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: risks,
                decoration: const InputDecoration(
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
                TextField(
                  controller: pharmacyName,
                  decoration: const InputDecoration(
                    labelText: "اسم الصيدلية",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: pharmacyPhone,
                  decoration: const InputDecoration(
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
        ElevatedButton(onPressed: _save, child: const Text("حفظ")),
      ],
    );
  }
}
