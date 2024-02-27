import 'package:formz/formz.dart';

// Definiere Validierungsfehler für die Checkbox
enum CheckboxValidationError {
  required('This field cannot be empty'); // oder andere spezifische Fehler, falls nötig

  final String message;
  const CheckboxValidationError(this.message);
}

// Modell für die Checkbox
class CheckboxModel extends FormzInput<bool, CheckboxValidationError> {
  const CheckboxModel.pure() : super.pure(false);
  const CheckboxModel.dirty([super.value = false]) : super.dirty();

  @override
  CheckboxValidationError? validator(bool value) {
    if (!value) {
      return CheckboxValidationError.required;
    }
    return null; // Kein Fehler
  }
}
