import 'package:formz/formz.dart';

enum FirstNameValidationError {
  required('Der Nachname darf nicht leer sein'),
  invalid('Der eingegebene Nachname ist nicht gültig.');

  final String message;
  const FirstNameValidationError(this.message);
}

class FirstNameModel extends FormzInput<String, FirstNameValidationError> {
  const FirstNameModel.pure() : super.pure('');
  const FirstNameModel.dirty([super.value = '']) : super.dirty();

  static final _firstNameRegex =
  RegExp(
      r"^[a-zA-ZäöüÄÖÜß]+(([\' ,.-][a-zA-ZäöüÄÖÜß ])?[a-zA-ZäöüÄÖÜß]*)*$"
  );

  @override
  FirstNameValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return FirstNameValidationError.required;
    }
    if (!_firstNameRegex.hasMatch(value.trim())) {
      return FirstNameValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
