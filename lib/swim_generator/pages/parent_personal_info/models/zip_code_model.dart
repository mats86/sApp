import 'package:formz/formz.dart';

enum ZipCodeValidationError {
  required('Eine Postleitzahl ist erforderlich.'),
  invalid('Die Postleitzahl muss aus 5 Zahlen bestehen.');

  final String message;
  const ZipCodeValidationError(this.message);
}

class ZipCodeModel extends FormzInput<String, ZipCodeValidationError> {
  const ZipCodeModel.pure() : super.pure('');
  const ZipCodeModel.dirty([super.value = '']) : super.dirty();

  @override
  ZipCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return ZipCodeValidationError.required;
    }
    // Überprüfen, ob die Postleitzahl genau 5 Zahlen enthält
    if (!RegExp(r'^\d{5}$').hasMatch(value.trim())) {
      return ZipCodeValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
