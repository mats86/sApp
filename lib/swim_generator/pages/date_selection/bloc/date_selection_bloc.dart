import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../graphql/graphql_queries.dart';
import '../model/model.dart';

part 'date_selection_event.dart';

part 'date_selection_repository.dart';

part 'date_selection_state.dart';

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  final DateSelectionRepository service;

  DateSelectionBloc(this.service) : super(const DateSelectionState()) {
    on<LoadFixDates>(_onLoadFixDates);
    on<UpdateHasFixedDesiredDate>(_onUpdateHasFixedDesiredDate);
    on<SelectFlexDate>(_onSelectFlexDate);
    on<SelectFixDate>(_onSelectFixDate);
    on<FixDateChanged>(_onFixDateChanged);
    on<UpdateSelectedDates>(_onUpdateSelectedDates);
    on<UpdateSelectedTimes>(_onUpdateSelectedTimes);
    on<UpdateSelectedDateTimeLength>(_onUpdateSelectedDateTimeLength);
    on<UpdateIsValid>(_onUpdateIsValid);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadFixDates(
    LoadFixDates event,
    Emitter<DateSelectionState> emit,
  ) async {
    emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.inProgress));
    try {
      var fixDates = await service.loadFixDatesSortedActive(
          event.swimCourseID, event.swimPoolIDs);
      emit(state.copyWith(
          fixDates: fixDates, loadingFixDates: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.failure));
    }
  }

  void _onUpdateHasFixedDesiredDate(
    UpdateHasFixedDesiredDate event,
    Emitter<DateSelectionState> emit,
  ) {
    emit(state.copyWith(hasFixedDesiredDate: event.hasFixedDesiredDate));
  }

  void _onSelectFlexDate(
      SelectFlexDate event, Emitter<DateSelectionState> emit) {
    emit(
        state.copyWith(flexFixDate: false, isValid: true, bookingDateTypID: 1));
  }

  void _onSelectFixDate(SelectFixDate event, Emitter<DateSelectionState> emit) {
    // final isValid = (state.flexFixDate);
    emit(state.copyWith(
      flexFixDate: true,
      isValid: false,
      bookingDateTypID: event.bookingDateTypID,
    ));
  }

  void _onFixDateChanged(
      FixDateChanged event, Emitter<DateSelectionState> emit) {
    final fixDateModel = FixDateModel.dirty(event.fixDateName);
    emit(
      state.copyWith(
        fixDateModel: fixDateModel,
        selectedFixDate: event.fixDate,
        isValid: Formz.validate(
          [fixDateModel],
        ),
      ),
    );
  }

  void _onUpdateSelectedDates(
    UpdateSelectedDates event,
    Emitter<DateSelectionState> emit,
  ) {
    List<TimeOfDay> fixedLengthTimeList = List.filled(
        event.selectedDates.length, const TimeOfDay(hour: 0, minute: 0));
    emit(
      state.copyWith(
          selectedDates: event.selectedDates,
          selectedTimes: fixedLengthTimeList),
    );
  }

  void _onUpdateSelectedTimes(
      UpdateSelectedTimes event, Emitter<DateSelectionState> emit) async {
    List<TimeOfDay>? updatedTimes = state.selectedTimes;
    List<DateTime>? selectedDates = state.selectedDates;

    if (event.index >= 0 &&
        event.index < updatedTimes!.length &&
        selectedDates != null) {
      updatedTimes[event.index] = event.selectedTime;

      List<DateTimeModel> updatedDateTimeModels = [];

      for (int i = 0; i < updatedTimes.length; i++) {
        final newDateTimeModel = DateTimeModel.dirty(
          DateTime(
            selectedDates[i].year,
            selectedDates[i].month,
            selectedDates[i].day,
            updatedTimes[i].hour,
            updatedTimes[i].minute,
          ),
        );
        updatedDateTimeModels.add(newDateTimeModel);
        selectedDates.add(newDateTimeModel.value!);
      }
      emit(
        state.copyWith(
          selectedTimes: updatedTimes,
          selectedDates: selectedDates,
          isValid: Formz.validate(updatedDateTimeModels),
        ),
      );
    }
  }

  void _onUpdateSelectedDateTimeLength(
    UpdateSelectedDateTimeLength event,
    Emitter<DateSelectionState> emit,
  ) {
    emit(state.copyWith(selectedDateTimeLength: event.selectedDateTimeLength));
  }

  void _onUpdateIsValid(UpdateIsValid event, Emitter<DateSelectionState> emit,) {
    emit(state.copyWith(isValid: true));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<DateSelectionState> emit) async {
    if (true) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
