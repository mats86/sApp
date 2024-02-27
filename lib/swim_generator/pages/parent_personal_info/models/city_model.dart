import 'package:formz/formz.dart';

// Definition der Validierungsfehler für CityModel
enum CityValidationError {
  required('Stadtname darf nicht leer sein'),
  invalid('Der eingegebene Stadtname ist ungültig.');

  final String message;

  const CityValidationError(this.message);
}

// CityModel-Klasse, die von FormzInput erbt
class CityModel extends FormzInput<String, CityValidationError> {
  const CityModel.pure() : super.pure('');

  const CityModel.dirty([super.value = '']) : super.dirty();

  // Regulärer Ausdruck zur Validierung von Stadtnamen
  static final _cityNameRegex =
      RegExp(r"[a-zA-ZäöüßÄÖÜ]+(([',. -][a-zA-ZäöüßÄÖÜ ])?[a-zA-ZäöüßÄÖÜ]*)*$");

  @override
  CityValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return CityValidationError.required;
    }
    if (!_cityNameRegex.hasMatch(value.trim())) {
      return CityValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
