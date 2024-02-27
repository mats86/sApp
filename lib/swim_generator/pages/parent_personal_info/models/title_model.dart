import 'package:formz/formz.dart';

enum TitleValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const TitleValidationError(this.message);
}

class TitleModel extends FormzInput<String, TitleValidationError> {
  const TitleModel.pure() : super.pure('');
  const TitleModel.dirty([super.value = '']) : super.dirty();

  @override
  TitleValidationError? validator(String value) {
    return value.trim().isEmpty ? TitleValidationError.required : null;
  }
}
