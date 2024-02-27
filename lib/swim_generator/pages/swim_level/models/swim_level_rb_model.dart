import 'package:formz/formz.dart';

enum SwimLevelRBValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const SwimLevelRBValidationError(this.message);
}

class SwimLevelRBModel extends FormzInput<String, SwimLevelRBValidationError> {
  const SwimLevelRBModel.pure() : super.pure('');
  const SwimLevelRBModel.dirty([super.value = '']) : super.dirty();

  @override
  SwimLevelRBValidationError? validator(String value) {
    return value.isEmpty ? SwimLevelRBValidationError.required : null;
  }
}
