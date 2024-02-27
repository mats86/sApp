import 'package:formz/formz.dart';

enum FixDateValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const FixDateValidationError(this.message);
}

class FixDateModel extends FormzInput<int, FixDateValidationError> {
  const FixDateModel.pure() : super.pure(0);
  const FixDateModel.dirty([super.value = 0]) : super.dirty();

  @override
  FixDateValidationError? validator(int value) {
    return value == 0 ? FixDateValidationError.required : null;
  }
}
