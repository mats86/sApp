import 'package:equatable/equatable.dart';

class PersonalInfo extends Equatable {
  const PersonalInfo({
    required this.parentTitle,
    required this.firstName,
    required this.lastName,
    required this.parentStreet,
    required this.streetNumber,
    required this.zipCode,
    required this.city,
    required this.email,
    required this.emailConfirm,
    required this.phoneNumber,
    required this.phoneNumberConfirm,
  });

  final String parentTitle;
  final String firstName;
  final String lastName;
  final String parentStreet;
  final String streetNumber;
  final String zipCode;
  final String city;
  final String email;
  final String emailConfirm;
  final String phoneNumber;
  final String phoneNumberConfirm;

  bool get isEmpty {
    return parentTitle.isEmpty &&
        firstName.isEmpty &&
        lastName.isEmpty &&
        parentStreet.isEmpty &&
        streetNumber.isEmpty &&
        zipCode.isEmpty &&
        city.isEmpty &&
        email.isEmpty &&
        emailConfirm.isEmpty &&
        phoneNumber.isEmpty &&
        phoneNumber.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  const PersonalInfo.empty()
      : this(
    parentTitle: '',
    firstName: '',
    lastName: '',
    parentStreet: '',
    streetNumber: '',
    zipCode: '',
    city: '',
    email: '',
    emailConfirm: '',
    phoneNumber: '',
    phoneNumberConfirm: '',
  );

  PersonalInfo copyWith({
    String? parentTitle,
    String? firstName,
    String? lastName,
    String? parentStreet,
    String? streetNumber,
    String? zipCode,
    String? city,
    String? email,
    String? emailConfirm,
    String? phoneNumber,
    String? phoneNumberConfirm,
  }) {
    return PersonalInfo(
      parentTitle: parentTitle ?? this.parentTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      parentStreet: parentStreet ?? this.parentStreet,
      streetNumber: streetNumber ?? this.streetNumber,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      email: email ?? this.email,
      emailConfirm: emailConfirm ?? this.emailConfirm,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberConfirm: phoneNumberConfirm ?? this.phoneNumberConfirm,
    );
  }

  @override
  List<Object?> get props => [
    parentTitle,
    firstName,
    lastName,
    parentStreet,
    streetNumber,
    zipCode,
    city,
    email,
    emailConfirm,
    phoneNumber,
    phoneNumberConfirm,
  ];
}
