import 'package:dashboard_doctor_app/Services/daily_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'daily_info_state.dart';

class DailyInfoCubit extends Cubit<DailyInfoState> {
  DailyInfoCubit() : super(DailyInfoInitial());

  Future<void> loadDailyInfo() async {
    emit(DailyInfoLoading());
    try {
      final list = await DailyInfoService.getAll();
      emit(DailyInfoLoaded(list));
    } catch (e) {
      emit(DailyInfoError(e.toString()));
    }
  }

  Future<void> addDailyInfo({
    required String medicalInfo1,
    required String medicalInfo2,
    required String drugName,
    required String indication1,
    required String indication2,
    required String risks,
    required String date,
  }) async {
    await DailyInfoService.add(
      medicalInfo1: medicalInfo1,
      medicalInfo2: medicalInfo2,
      drugName: drugName,
      indication1: indication1,
      indication2: indication2,
      risks: risks,
      date: date,
    );

    await loadDailyInfo();
  }

  Future<void> updateDailyInfo({
    required int id,
    required String medicalInfo1,
    required String medicalInfo2,
    required String drugName,
    required String indication1,
    required String indication2,
    required String risks,
    required String date,
  }) async {
    await DailyInfoService.update(
      id: id,
      medicalInfo1: medicalInfo1,
      medicalInfo2: medicalInfo2,
      drugName: drugName,
      indication1: indication1,
      indication2: indication2,
      risks: risks,
      date: date,
    );

    await loadDailyInfo();
  }

  Future<void> deleteDailyInfo(int id) async {
    await DailyInfoService.delete(id);
    await loadDailyInfo();
  }
}