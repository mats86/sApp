import 'package:formz/formz.dart';

// Definition der Validierungsfehler für EmailModel
enum EmailValidationError {
  required('E-Mail darf nicht leer sein'),
  invalid('Die eingegebene E-Mail ist ungültig.');

  final String message;
  const EmailValidationError(this.message);
}

// EmailModel-Klasse, die von FormzInput erbt
class EmailModel extends FormzInput<String, EmailValidationError> {
  const EmailModel.pure() : super.pure('');
  const EmailModel.dirty([super.value = '']) : super.dirty();

  // Regulärer Ausdruck zur Validierung von E-Mail-Adressen
  static final _emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return EmailValidationError.required;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return EmailValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
