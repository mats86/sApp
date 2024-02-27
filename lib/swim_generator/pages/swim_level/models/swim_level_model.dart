import 'package:formz/formz.dart';

import '../../../models/swim_level.dart';


enum SwimLevelValidationError {
  required('Ein Schwimmniveau muss ausgewählt werden.');

  final String message;
  const SwimLevelValidationError(this.message);
}

class SwimLevelModel extends FormzInput<SwimLevelEnum?, SwimLevelValidationError> {
  const SwimLevelModel.pure() : super.pure(null);
  const SwimLevelModel.dirty([super.value]) : super.dirty();

  @override
  SwimLevelValidationError? validator(SwimLevelEnum? value) {
    if (value == null) {
      return SwimLevelValidationError.required;
    }
    return null;
  }
}
