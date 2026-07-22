import 'package:dashboard_doctor_app/Services/on_duty_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'on_duty_state.dart';

class OnDutyCubit extends Cubit<OnDutyState> {
  OnDutyCubit() : super(OnDutyInitial());

  Future<void> loadOnDuties() async {
    emit(OnDutyLoading());
    try {
      final list = await OnDutyService.getAll();
      emit(OnDutyLoaded(list));
    } catch (e) {
      emit(OnDutyError(e.toString()));
    }
  }

  Future<void> addOnDuty({
    required int pharmacyId,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    await OnDutyService.add(
      pharmacyId: pharmacyId,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    await loadOnDuties();
  }

  Future<void> deleteOnDuty(int id) async {
    await OnDutyService.delete(id);
    await loadOnDuties();
  }
}