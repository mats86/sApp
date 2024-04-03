import 'package:formz/formz.dart';

enum SwimSchoolValidationError {
  required('Bitte wählen Sie einen Schwimmschule aus'),
  invalid('Schwimmschule you have entered is not valid.');

  final String message;
  const SwimSchoolValidationError(this.message);
}

class SwimSchoolModel extends FormzInput<String, SwimSchoolValidationError> {
  const SwimSchoolModel.pure() : super.pure('');
  const SwimSchoolModel.dirty([super.value = '']) : super.dirty();

  @override
  SwimSchoolValidationError? validator(String value) {
    return value.isEmpty ? SwimSchoolValidationError.required : null;
  }
}
