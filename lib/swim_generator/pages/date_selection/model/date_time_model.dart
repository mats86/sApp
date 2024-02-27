import 'package:formz/formz.dart';

enum DateTimeValidationError {
  required('Ein Datum ist erforderlich'),
  invalid('Das eingegebene Datum ist ungültig.');

  final String message;
  const DateTimeValidationError(this.message);
}

class DateTimeModel extends FormzInput<DateTime?, DateTimeValidationError> {
  const DateTimeModel.pure() : super.pure(null);
  const DateTimeModel.dirty([super.value]) : super.dirty();

  @override
  DateTimeValidationError? validator(DateTime? value) {
    if (value == null) {
      return DateTimeValidationError.required;
    }

    // Hier können Sie weitere Validierungen hinzufügen
    // Beispiel:
    // if (value.isBefore(DateTime.now())) {
    //   return DateTimeValidationError.invalid;
    // }

    return null; // Kein Fehler
  }
}
