import 'package:formz/formz.dart';

// Definition der Validierungsfehler für StreetNumberModel
enum StreetNumberValidationError {
  required('Hausnummer darf nicht leer sein'),
  invalid('Die eingegebene Hausnummer ist ungültig.');

  final String message;
  const StreetNumberValidationError(this.message);
}

// StreetNumberModel-Klasse, die von FormzInput erbt
class StreetNumberModel extends FormzInput<String, StreetNumberValidationError> {
  const StreetNumberModel.pure() : super.pure('');
  const StreetNumberModel.dirty([super.value = '']) : super.dirty();

  // Regulärer Ausdruck zur Validierung von deutschen Hausnummern
  static final _houseNumberRegex = RegExp(r"^\d+[a-zA-ZäöüßÄÖÜ]?$");

  @override
  StreetNumberValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return StreetNumberValidationError.required;
    }
    if (!_houseNumberRegex.hasMatch(value.trim())) {
      return StreetNumberValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
