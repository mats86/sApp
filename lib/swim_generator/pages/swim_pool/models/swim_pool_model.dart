import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_pool/models/swim_pool.dart';

enum SwimPoolModelsValidationError { required, invalid }

extension Explanation on SwimPoolModelsValidationError {
  String get message {
    switch (this) {
      case SwimPoolModelsValidationError.required:
        return 'Bitte wählen Sie mindestens eine Option aus';
      case SwimPoolModelsValidationError.invalid:
        return 'Die eingegebene Option ist ungültig';
      default:
        return '';
    }
  }
}

class SwimPoolModel extends FormzInput<List<SwimPool>, SwimPoolModelsValidationError> {
  const SwimPoolModel.pure() : super.pure(const []);
  const SwimPoolModel.dirty([super.value = const []]) : super.dirty();

  @override
  SwimPoolModelsValidationError? validator(List<SwimPool> value) {
    if (value.isEmpty || value.every((pool) => !pool.isSelected)) {
      return SwimPoolModelsValidationError.required;
    }
    return null;
  }
}
