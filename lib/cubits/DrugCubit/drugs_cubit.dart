import 'package:dashboard_doctor_app/Services/drug_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drugs_state.dart';

class DrugsCubit extends Cubit<DrugsState> {
  DrugsCubit() : super(DrugsInitial());

  Future<void> loadDrugs() async {
    emit(DrugsLoading());
    try {
      final drugs = await DrugService.getAll();
      emit(DrugsLoaded(drugs));
    } catch (e) {
      emit(DrugsError(e.toString()));
    }
  }

  Future<void> addDrug({
    required String name,
    String? indications,
    String? risks,
    required bool requiresPrescription,
    required bool isRare,
    String? pharmacyName,
    String? pharmacyPhone,
  }) async {
    await DrugService.add(
      name: name,
      indications: indications,
      risks: risks,
      requiresPrescription: requiresPrescription,
      isRare: isRare,
      missingPharmacies: isRare && pharmacyName != null
          ? [
              {
                "name": pharmacyName,
                "phone": pharmacyPhone ?? "",
              }
            ]
          : null,
    );

    await loadDrugs();
  }

  Future<void> updateDrug({
    required int id,
    required String name,
    String? indications,
    String? risks,
    required bool requiresPrescription,
    required bool isRare,
    String? pharmacyName,
    String? pharmacyPhone,
  }) async {
    await DrugService.update(
      id: id,
      name: name,
      indications: indications,
      risks: risks,
      requiresPrescription: requiresPrescription,
      isRare: isRare,
      missingPharmacies: isRare && pharmacyName != null
          ? [
              {
                "name": pharmacyName,
                "phone": pharmacyPhone ?? "",
              }
            ]
          : null,
    );

    await loadDrugs();
  }

  Future<void> deleteDrug(int id) async {
    await DrugService.delete(id);
    await loadDrugs();
  }
}