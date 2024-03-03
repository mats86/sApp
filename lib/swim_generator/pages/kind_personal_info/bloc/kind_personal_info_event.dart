part of 'kind_personal_info_bloc.dart';

abstract class KindPersonalInfoEvent extends Equatable {
  const KindPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class UpdateChildInfoIndex extends KindPersonalInfoEvent {}

class FirstNameChanged extends KindPersonalInfoEvent {
  final String firstName;
  final int index;

  const FirstNameChanged({required this.index, required this.firstName});

  @override
  List<Object> get props => [index, firstName];
}


final class FirstNameUnfocused extends KindPersonalInfoEvent {}

class LastNameChanged extends KindPersonalInfoEvent {
  final String lastName;
  final int index;
  const LastNameChanged({required this.index, required this.lastName});

  @override
  List<Object> get props => [index, lastName];
}

final class LastNameUnfocused extends KindPersonalInfoEvent {}

class PhysicalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  final int index;
  const PhysicalDelayChanged({required this.index, required this.isChecked});

  @override
  List<Object> get props => [index, isChecked];
}

class MentalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  final int index;
  const MentalDelayChanged({required this.index, required this.isChecked});

  @override
  List<Object> get props => [index, isChecked];
}

class NoLimitsChanged extends KindPersonalInfoEvent {
  final bool isChecked;
  final int index;
  const NoLimitsChanged({required this.index, required this.isChecked});

  @override
  List<Object> get props => [index, isChecked];
}

class FormSubmitted extends KindPersonalInfoEvent {}