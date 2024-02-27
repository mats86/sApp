import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/models.dart';

part 'swim_level_event.dart';

part 'swim_level_state.dart';

class SwimLevelBloc extends Bloc<SwimLevelEvent, SwimLevelState> {
  SwimLevelBloc() : super(const SwimLevelState()) {
    on<IsDirectLinks>(_onIsDirectLinks);
    on<SwimLevelChanged>(_onSwimLevelChanged);
    on<LoadSwimLevelOptions>(_onLoadSwimLevelOptions);
    on<SwimLevelRBChanged>(_onSwimLevelRBChanged);
    on<SwimLevelOptionCheckboxChanged>(_onSwimLevelOptionCheckboxChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onIsDirectLinks(
      IsDirectLinks event,
      Emitter<SwimLevelState> emit,
      ) {
    emit(state.copyWith(isDirectLinks: event.isDirectLinks));
  }

  void _onSwimLevelChanged(
      SwimLevelChanged event,
      Emitter<SwimLevelState> emit,
      ) {
    final swimLevelModel = SwimLevelModel.dirty(event.swimLevelModel.value);

    emit(
      state.copyWith(
        swimLevelModel: swimLevelModel,
        isValid: Formz.validate([swimLevelModel]),
      ),
    );
  }

  void _onLoadSwimLevelOptions(
      LoadSwimLevelOptions event, Emitter<SwimLevelState> emit) {
    emit(state.copyWith(swimLevelOptions: event.swimLevelOptions));
  }

  void _onSwimLevelRBChanged(
      SwimLevelRBChanged event, Emitter<SwimLevelState> emit) {
    final swimLevel = SwimLevelRBModel.dirty(event.swimLevelName);
    emit(
      state.copyWith(
          swimLevelRB: swimLevel, selectedSeimLevelRB: event.swimLeveRB),
    );
  }

  void _onSwimLevelOptionCheckboxChanged(
      SwimLevelOptionCheckboxChanged event, Emitter<SwimLevelState> emit) {
    var updatedOptions = state.swimLevelOptions.map((option) {
      if (option.name == event.option.name) {
        // Vergleich basierend auf einem eindeutigen Feld
        return option.copyWith(isChecked: event.isChecked);
      }
      return option;
    }).toList();
    emit(state.copyWith(swimLevelOptions: updatedOptions));
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<SwimLevelState> emit,
      ) async {
    final swimLevelModel = SwimLevelModel.dirty(state.swimLevelModel.value);
    emit(
      state.copyWith(
        swimLevelModel: swimLevelModel,
        isValid: Formz.validate(
          [swimLevelModel],
        ),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // await userRepository.updateSwimLevel(
      //   swimLevel: swimLevelModel.value!,
      // );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
