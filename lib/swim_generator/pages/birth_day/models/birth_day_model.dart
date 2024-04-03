import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

enum BirthdayValidationError {
  required('Geburtstag darf nicht leer sein.'),
  invalid('Das Geburtstag ist ungültig.');

  final String message;
  const BirthdayValidationError(this.message);
}

class BirthDayModel extends FormzInput<DateTime?, BirthdayValidationError> {
  const BirthDayModel.pure() : super.pure(null);
  const BirthDayModel.dirty([super.value]) : super.dirty();

  static final _birthdayRegex =
  RegExp(r"^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.\d{4}$");

  @override
  BirthdayValidationError? validator(DateTime? value) {
    if (value == null) {
      return BirthdayValidationError.required;
    } else {
      String dateString = DateFormat('dd.MM.yyyy').format(value);
      if (!_birthdayRegex.hasMatch(dateString)) {
        return BirthdayValidationError.invalid;
      }
      return null;
    }
  }

}
