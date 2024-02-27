import 'package:formz/formz.dart';

enum SwimSeasonValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const SwimSeasonValidationError(this.message);
}

class SwimSeasonModel extends FormzInput<String, SwimSeasonValidationError> {
  const SwimSeasonModel.pure() : super.pure('');
  const SwimSeasonModel.dirty([super.value = '']) : super.dirty();

  @override
  SwimSeasonValidationError? validator(String value) {
    return value.isEmpty ? SwimSeasonValidationError.required : null;
  }
}
