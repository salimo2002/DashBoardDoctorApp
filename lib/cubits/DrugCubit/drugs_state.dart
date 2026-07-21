import 'package:dashboard_doctor_app/models/drug_model.dart';

abstract class DrugsState {}

class DrugsInitial extends DrugsState {}

class DrugsLoading extends DrugsState {}

class DrugsLoaded extends DrugsState {
  final List<DrugModel> drugs;
  DrugsLoaded(this.drugs);
}

class DrugsError extends DrugsState {
  final String message;
  DrugsError(this.message);
}