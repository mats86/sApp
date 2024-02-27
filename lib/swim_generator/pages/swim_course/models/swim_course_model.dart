import 'package:formz/formz.dart';

enum SwimCourseValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const SwimCourseValidationError(this.message);
}

class SwimCourseModel extends FormzInput<String, SwimCourseValidationError> {
  const SwimCourseModel.pure() : super.pure('');
  const SwimCourseModel.dirty([super.value = '']) : super.dirty();

  @override
  SwimCourseValidationError? validator(String value) {
    return value.isEmpty ? SwimCourseValidationError.required : null;
  }
}
