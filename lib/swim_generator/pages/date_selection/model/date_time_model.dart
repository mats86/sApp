import 'package:formz/formz.dart';

enum DateTimeValidationError {
  required('Ein Datum ist erforderlich'),
  invalid('Das eingegebene Datum ist ungültig.'),
  timeOutOfRange('Die Zeit muss zwischen 09:00 und 18:00 liegen.');

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

    // Zeitvalidierung hinzufügen
    if (value.hour < 9 || value.hour >= 18) {
      // Wenn die Zeit vor 9 Uhr oder nach 18 Uhr ist,
      // dann geben wir einen Fehler zurück.
      return DateTimeValidationError.timeOutOfRange;
    }

    // Weitere Validierungen können hier hinzugefügt werden, wie vorherige Beispiele.

    return null; // Kein Fehler
  }
}
