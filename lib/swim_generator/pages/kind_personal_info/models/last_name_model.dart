
import 'package:formz/formz.dart';

enum LastNameValidationError {
  required('Der Nachname darf nicht leer sein'),
  invalid('Der eingegebene Nachname ist nicht gültig.');

  final String message;
  const LastNameValidationError(this.message);
}

class LastNameModel extends FormzInput<String, LastNameValidationError> {
  const LastNameModel.pure() : super.pure('');
  const LastNameModel.dirty([super.value = '']) : super.dirty();

  static final _lastNameRegex =
  RegExp(
      r"^[a-zA-ZäöüÄÖÜß]+(([\' ,.-][a-zA-ZäöüÄÖÜß ])?[a-zA-ZäöüÄÖÜß]*)*$"
  );

  @override
  LastNameValidationError? validator(String value) {
    return value.trim().isEmpty
        ? LastNameValidationError.required
        : _lastNameRegex.hasMatch(value.trim())
        ? null
        : LastNameValidationError.invalid;
  }
}