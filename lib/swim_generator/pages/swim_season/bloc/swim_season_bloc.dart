import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/swim_season.dart';
import '../models/swim_season_model.dart';

part 'swim_season_event.dart';

part 'swim_season_state.dart';

class SwimSeasonBloc extends Bloc<SwimSeasonEvent, SwimSeasonState> {
  SwimSeasonBloc() : super(const SwimSeasonState()) {
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadSwimSeasonOptions(
      LoadSwimSeasonOptions event, Emitter<SwimSeasonState> emit) {
    emit(state.copyWith(swimSeasonOptions: event.swimSeasonOptions));
  }

  void _onSwimSeasonChanged(
      SwimSeasonChanged event, Emitter<SwimSeasonState> emit) {
    final swimSeason = SwimSeasonModel.dirty(event.swimSeasonName);
    emit(
      state.copyWith(
        swimSeason: swimSeason,
        selectedSwimSeason: event.season,
        isValid: Formz.validate(
          [swimSeason],
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<SwimSeasonState> emit,
      ) async {
    emit(
      state.copyWith(
        isValid: Formz.validate(
          [state.swimSeason],
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
