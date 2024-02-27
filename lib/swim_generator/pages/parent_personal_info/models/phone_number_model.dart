import 'package:formz/formz.dart';

// Definition der Validierungsfehler für PhoneNumberModel
enum PhoneNumberValidationError {
  required('Telefonnummer darf nicht leer sein'),
  invalid('Die eingegebene Telefonnummer ist ungültig.');

  final String message;
  const PhoneNumberValidationError(this.message);
}

// PhoneNumberModel-Klasse, die von FormzInput erbt
class PhoneNumberModel extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberModel.pure() : super.pure('');
  const PhoneNumberModel.dirty([super.value = '']) : super.dirty();

  // Regulärer Ausdruck zur Validierung von deutschen Telefonnummern
  static final _phoneNumberRegex = RegExp(
      r"^(?:\+49|0)?[1-9]\d{1,14}$"
  );

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return PhoneNumberValidationError.required;
    }
    if (!_phoneNumberRegex.hasMatch(value.trim())) {
      return PhoneNumberValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
