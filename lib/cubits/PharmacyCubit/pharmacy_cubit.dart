import 'package:dashboard_doctor_app/Services/pharmacy_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PharmacyInitial());

  Future<void> loadPharmacies() async {
    emit(PharmacyLoading());
    try {
      final pharmacies = await PharmacyService.getAll();
      emit(PharmacyLoaded(pharmacies));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }

  Future<void> addPharmacy({
    required String name,
    String? address,
    String? phoneNumber,
    String? openingTime,
    String? closingTime,
    double? latitude,
    double? longitude,
  }) async {
    await PharmacyService.add(
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      openingTime: openingTime,
      closingTime: closingTime,
      latitude: latitude,
      longitude: longitude,
    );
    await loadPharmacies();
  }

  Future<void> updatePharmacy({
    required int id,
    required String name,
    String? address,
    String? phoneNumber,
    String? openingTime,
    String? closingTime,
    double? latitude,
    double? longitude,
  }) async {
    await PharmacyService.update(
      id: id,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      openingTime: openingTime,
      closingTime: closingTime,
      latitude: latitude,
      longitude: longitude,
    );
    await loadPharmacies();
  }

  Future<void> deletePharmacy(int id) async {
    await PharmacyService.delete(id);
    await loadPharmacies();
  }
}