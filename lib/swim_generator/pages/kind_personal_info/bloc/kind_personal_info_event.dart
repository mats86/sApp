part of 'kind_personal_info_bloc.dart';

abstract class KindPersonalInfoEvent extends Equatable {
  const KindPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class UpdateChildInfo extends KindPersonalInfoEvent {
  final ChildInfo childInfo;

  const UpdateChildInfo({required this.childInfo});

  @override
  List<Object> get props => [childInfo];
}

class FirstNameChanged extends KindPersonalInfoEvent {
  final String firstName;

  const FirstNameChanged({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends KindPersonalInfoEvent {
  final String lastName;

  const LastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class PhysicalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;

  const PhysicalDelayChanged({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

class BirthDayChanged extends KindPersonalInfoEvent {
  final DateTime birthDay;
  const BirthDayChanged({required this.birthDay});

  @override
  List<Object> get props => [birthDay];
}

class SelectChild extends KindPersonalInfoEvent {}

class SelectFriend extends KindPersonalInfoEvent {

  const SelectFriend();
}


class MentalDelayChanged extends KindPersonalInfoEvent {
  final bool isChecked;

  const MentalDelayChanged({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

class NoLimitsChanged extends KindPersonalInfoEvent {
  final bool isChecked;

  const NoLimitsChanged({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

class CustomerInvitedFirstNameChanged extends KindPersonalInfoEvent {
  final String firstName;

  const CustomerInvitedFirstNameChanged({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class CustomerInvitedLastNameChanged extends KindPersonalInfoEvent {
  final String lastName;

  const CustomerInvitedLastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class CustomerInvitedEmailChanged extends KindPersonalInfoEvent {
  final String email;

  const CustomerInvitedEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class CustomerInvitedPhoneNumberChanged extends KindPersonalInfoEvent {
  final String phoneNumber;

  const CustomerInvitedPhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class FormSubmitted extends KindPersonalInfoEvent {
  final SwimCourse selectedCourse;

  const FormSubmitted({required this.selectedCourse});

  @override
  List<Object> get props => [selectedCourse];
}

class LoadSwimBookingByCode extends KindPersonalInfoEvent {
  final String swimBookingCode;

  const LoadSwimBookingByCode({required this.swimBookingCode});

  @override
  List<Object> get props => [swimBookingCode];
}

class CloseAlertDialog extends KindPersonalInfoEvent {}
