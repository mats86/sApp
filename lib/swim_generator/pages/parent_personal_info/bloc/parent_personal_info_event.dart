part of 'parent_personal_info_bloc.dart';

abstract class ParentPersonalInfoEvent extends Equatable {
  const ParentPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadParentTitleOptions extends ParentPersonalInfoEvent {}

class TitleChanged extends ParentPersonalInfoEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class ParentFirstNameChanged extends ParentPersonalInfoEvent {
  final String firstName;
  const ParentFirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class ParentLastNameChanged extends ParentPersonalInfoEvent {
  final String lastName;
  const ParentLastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class ParentStreetChanged extends ParentPersonalInfoEvent {
  final String street;
  const ParentStreetChanged(this.street);

  @override
  List<Object> get props => [street];
}

class ParentStreetNumberChanged extends ParentPersonalInfoEvent {
  final String streetNumber;
  const ParentStreetNumberChanged(this.streetNumber);

  @override
  List<Object> get props => [streetNumber];
}

class ParentZipCodeChanged extends ParentPersonalInfoEvent {
  final String zipCode;
  const ParentZipCodeChanged(this.zipCode);

  @override
  List<Object> get props => [zipCode];
}

class ParentCityChanged extends ParentPersonalInfoEvent {
  final String city;
  const ParentCityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class ParentEmailChanged extends ParentPersonalInfoEvent {
  final String email;
  const ParentEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class ParentEmailConfirmChanged extends ParentPersonalInfoEvent {
  final String emailConfirm;
  const ParentEmailConfirmChanged(this.emailConfirm);

  @override
  List<Object> get props => [emailConfirm];
}

class ParentPhoneNumberChanged extends ParentPersonalInfoEvent {
  final String phoneNumber;
  const ParentPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class ParentPhoneNumberConfirmChanged extends ParentPersonalInfoEvent {
  final String phoneNumberConfirm;
  const ParentPhoneNumberConfirmChanged(this.phoneNumberConfirm);

  @override
  List<Object> get props => [phoneNumberConfirm];
}

class IsEmailExists extends ParentPersonalInfoEvent {
  final bool isEmailExists;
  const IsEmailExists(this.isEmailExists);

  @override
  List<Object> get props => [isEmailExists];
}

class FormSubmitted extends ParentPersonalInfoEvent {}