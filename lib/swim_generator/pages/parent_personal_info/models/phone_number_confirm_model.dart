import 'package:formz/formz.dart';

// Definition der Validierungsfehler für PhoneNumberConfirmModel
enum PhoneNumberConfirmValidationError {
  required('Bestätigungs-Telefonnummer darf nicht leer sein'),
  mismatch('Die Bestätigungs-Telefonnummer stimmt nicht überein');

  final String message;
  const PhoneNumberConfirmValidationError(this.message);
}

// PhoneNumberConfirmModel-Klasse, die von FormzInput erbt
class PhoneNumberConfirmModel extends FormzInput<String, PhoneNumberConfirmValidationError> {
  final String originalPhoneNumber;

  const PhoneNumberConfirmModel.pure({this.originalPhoneNumber = ''}) : super.pure('');
  const PhoneNumberConfirmModel.dirty({required this.originalPhoneNumber, String value = ''}) : super.dirty(value);

  @override
  PhoneNumberConfirmValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return PhoneNumberConfirmValidationError.required;
    }
    if (value.trim() != originalPhoneNumber) {
      return PhoneNumberConfirmValidationError.mismatch;
    }
    return null; // Kein Fehler
  }
}
