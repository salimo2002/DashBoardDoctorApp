import 'package:dashboard_doctor_app/models/on_duty_model.dart';

abstract class OnDutyState {}

class OnDutyInitial extends OnDutyState {}

class OnDutyLoading extends OnDutyState {}

class OnDutyLoaded extends OnDutyState {
  final List<OnDutyModel> onDuties;
  OnDutyLoaded(this.onDuties);
}

class OnDutyError extends OnDutyState {
  final String message;
  OnDutyError(this.message);
}