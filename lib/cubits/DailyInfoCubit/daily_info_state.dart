
import 'package:dashboard_doctor_app/models/daily_info_model.dart';

abstract class DailyInfoState {}

class DailyInfoInitial extends DailyInfoState {}

class DailyInfoLoading extends DailyInfoState {}

class DailyInfoLoaded extends DailyInfoState {
  final List<DailyInfoModel> items;
  DailyInfoLoaded(this.items);
}

class DailyInfoError extends DailyInfoState {
  final String message;
  DailyInfoError(this.message);
}