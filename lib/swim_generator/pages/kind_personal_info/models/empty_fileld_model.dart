import 'package:formz/formz.dart';

enum FieldValidationError {
  required('Das Field darf nicht leer sein.');

  final String message;
  const FieldValidationError(this.message);
}

class EmptyFieldModel extends FormzInput<String, FieldValidationError> {
  const EmptyFieldModel.pure() : super.pure('');
  const EmptyFieldModel.dirty([super.value = '']) : super.dirty();

  @override
  FieldValidationError? validator(String value) {
    if (value.isEmpty) {
      return FieldValidationError.required;
    }
    return null;
  }
}
