import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_course/models/swim_course.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/models.dart';

part 'birth_day_event.dart';

part 'birth_day_state.dart';

part 'birth_day_repository.dart';

class BirthDayBloc extends Bloc<BirthDayEvent, BirthDayState> {
  final BirthDayRepository service;

  BirthDayBloc(this.service) : super(const BirthDayState()) {
    on<BirthDayChanged>(_onBirthDayChanged);
    on<CancelAlert>(_onCancelAlert);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onBirthDayChanged(
      BirthDayChanged event,
      Emitter<BirthDayState> emit,
      ) async {
    final birthDay = BirthDayModel.dirty(event.birthDay);
    emit(
      state.copyWith(
        birthDay: birthDay,
        isValid: Formz.validate([birthDay]),
      ),
    );
  }

  DateTime getSpecificDate() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return DateTime(currentYear, 6, 1);
  }

  double calculateAge(DateTime birthDate, DateTime specificDate) {
    int yearDifference = specificDate.year - birthDate.year;
    int monthDifference = specificDate.month - birthDate.month;
    int dayDifference = specificDate.day - birthDate.day;

    if (monthDifference < 0 || (monthDifference == 0 && dayDifference < 0)) {
      yearDifference--;
      monthDifference += 12;
    }

    if (dayDifference < 0) {
      monthDifference--;
    }

    double age = yearDifference + (monthDifference / 12.0);
    return age;
  }

  void _onCancelAlert(
      CancelAlert event,
      Emitter<BirthDayState> emit,
      ) {
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.initial));
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<BirthDayState> emit,
      ) async {
    final birthDay = BirthDayModel.dirty(state.birthDay.value);
    emit(
      state.copyWith(birthDay: birthDay, isValid: Formz.validate([birthDay])),
    );
    double age = calculateAge(birthDay.value!, getSpecificDate());
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (event.isDirectLinks) {
        emit(state.copyWith(
          autoSelectedCourse:
          await service.getSwimCourseById(event.swimCourseID),
        ));
        if ((age >= state.autoSelectedCourse.swimCourseMinAge) &&
            (age <= state.autoSelectedCourse.swimCourseMaxAge)) {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
        }
      } else {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      }
    }
  }
}
