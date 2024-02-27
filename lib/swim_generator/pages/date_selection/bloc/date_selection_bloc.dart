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
    on<UpdateDateTime1>(_onUpdateDateTime1);
    on<UpdateDateTime2>(_onUpdateDateTime2);
    on<UpdateDateTime3>(_onUpdateDateTime3);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadFixDates(
    LoadFixDates event,
    Emitter<DateSelectionState> emit,
  ) async {
    emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.inProgress));
    try {
      var fixDates =
          await service.loadFixDates(event.swimCourseID, event.swimPoolIDs);
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
    final isValid = (state.flexFixDate);
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

  void _onUpdateDateTime1(
    UpdateDateTime1 event,
    Emitter<DateSelectionState> emit,
  ) {
    if (event.date != null && event.time != null) {
      final dateTime1 = DateTimeModel.dirty(
        DateTime(
          event.date!.year,
          event.date!.month,
          event.date!.day,
          event.time!.hour,
          event.time!.minute,
        ),
      );
      emit(
        state.copyWith(
          dateTime1: dateTime1.value,
          isValid: Formz.validate(
            [
              dateTime1,
              DateTimeModel.dirty(state.dateTime2),
              DateTimeModel.dirty(state.dateTime3),
            ],
          ),
        ),
      );
    } else {}
  }

  void _onUpdateDateTime2(
    UpdateDateTime2 event,
    Emitter<DateSelectionState> emit,
  ) {
    if (event.date != null && event.time != null) {
      final dateTime2 = DateTimeModel.dirty(
        DateTime(
          event.date!.year,
          event.date!.month,
          event.date!.day,
          event.time!.hour,
          event.time!.minute,
        ),
      );
      emit(
        state.copyWith(
          dateTime2: dateTime2.value,
          isValid: Formz.validate(
            [
              DateTimeModel.dirty(state.dateTime1),
              dateTime2,
              DateTimeModel.dirty(state.dateTime3),
            ],
          ),
        ),
      );
    } else {}
  }

  void _onUpdateDateTime3(
    UpdateDateTime3 event,
    Emitter<DateSelectionState> emit,
  ) {
    if (event.date != null && event.time != null) {
      final dateTime3 = DateTimeModel.dirty(
        DateTime(
          event.date!.year,
          event.date!.month,
          event.date!.day,
          event.time!.hour,
          event.time!.minute,
        ),
      );
      emit(
        state.copyWith(
          dateTime3: dateTime3.value,
          isValid: Formz.validate(
            [
              DateTimeModel.dirty(state.dateTime1),
              DateTimeModel.dirty(state.dateTime2),
              dateTime3,
            ],
          ),
        ),
      );
    } else {}
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
