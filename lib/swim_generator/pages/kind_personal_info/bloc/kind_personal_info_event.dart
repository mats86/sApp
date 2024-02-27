part of 'kind_personal_info_bloc.dart';

abstract class KindPersonalInfoEvent extends Equatable {
  const KindPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends KindPersonalInfoEvent {
  final String firstName;
  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

final class FirstNameUnfocused extends KindPersonalInfoEvent {}

class LastNameChanged extends KindPersonalInfoEvent {
  final String lastName;
  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

final class LastNameUnfocused extends KindPersonalInfoEvent {}

class PhysicalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  const PhysicalDelayChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class MentalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  const MentalDelayChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class NoLimitsChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  const NoLimitsChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class FormSubmitted extends KindPersonalInfoEvent {}