import 'package:formz/formz.dart';

// Definition der Validierungsfehler für StreetModel
enum StreetValidationError {
  required('Straßenname darf nicht leer sein'),
  invalid('Der eingegebene Straßenname ist ungültig.');

  final String message;

  const StreetValidationError(this.message);
}

class StreetModel extends FormzInput<String, StreetValidationError> {
  const StreetModel.pure() : super.pure('');

  const StreetModel.dirty([super.value = '']) : super.dirty();

  static final _streetNameRegex = RegExp(
      r"^[a-zA-ZäöüßÄÖÜ0-9]+(([',. -][a-zA-ZäöüßÄÖÜ0-9 ])?[a-zA-ZäöüßÄÖÜ0-9]*)*$");

  @override
  StreetValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return StreetValidationError.required;
    }
    if (!_streetNameRegex.hasMatch(value.trim())) {
      return StreetValidationError.invalid;
    }
    return null;
  }
}
