import 'package:formz/formz.dart';

// Definition der Validierungsfehler für EmailConfirmModel
enum EmailConfirmValidationError {
  required('Bestätigungs-E-Mail darf nicht leer sein'),
  mismatch('Die Bestätigungs-E-Mail stimmt nicht überein');

  final String message;
  const EmailConfirmValidationError(this.message);
}

// EmailConfirmModel-Klasse, die von FormzInput erbt
class EmailConfirmModel extends FormzInput<String, EmailConfirmValidationError> {
  final String originalEmail;

  const EmailConfirmModel.pure({this.originalEmail = ''}) : super.pure('');
  const EmailConfirmModel.dirty({required this.originalEmail, String value = ''}) : super.dirty(value);

  @override
  EmailConfirmValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return EmailConfirmValidationError.required;
    }
    if (value.trim() != originalEmail) {
      return EmailConfirmValidationError.mismatch;
    }
    return null; // Kein Fehler
  }
}
