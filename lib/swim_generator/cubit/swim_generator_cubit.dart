import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/config_app.dart';
import 'package:swim_generator_app/swim_generator/models/date_selection.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/models/swim_season_info.dart';

import '../models/models.dart';
import '../pages/swim_season/models/swim_season.dart';

part 'swim_generator_state.dart';

class SwimGeneratorCubit extends Cubit<SwimGeneratorState> {
  SwimGeneratorCubit(this.stepperLength) : super(const SwimGeneratorState());
  final int stepperLength;

  void stepTapped(int tappedIndex) {
    emit(SwimGeneratorState(
      activeStepperIndex: tappedIndex,
    ));
  }

  void stepContinued({bool isAdultCourse = false}) {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(
        state.copyWith(
          activeStepperIndex: state.activeStepperIndex + 1,
        ),
      );
      if (isAdultCourse) {
        emit(state.copyWith(isAdultCourse: isAdultCourse));
      }
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
      ));
    }
  }

  void updateSwimLevel(SwimLevelEnum? swimLevel) {
    emit(state.copyWith(
        swimLevel: state.swimLevel.copyWith(
          swimLevel: swimLevel,
        )));
  }

  void updateSwimSeasonInfo(SwimSeason? swimSeason) {
    emit(state.copyWith(
        swimSeasonInfo: state.swimSeasonInfo.copyWith(swimSeason: swimSeason)));
  }

  void updateBirthDay(DateTime? birthDay) {
    emit(state.copyWith(birthDay: state.birthDay.copyWith(birthDay: birthDay)));
  }

  void updateSwimCourseInfo(SwimCourseInfo? swimCourseInfo) {
    emit(state.copyWith(swimCourseInfo: swimCourseInfo));
  }

  void updateSwimPoolInfo(List<SwimPoolInfo>? swimPoolInfo) {
    emit(state.copyWith(swimPools: swimPoolInfo));
  }

  void updateDateSelection(DateSelection? dateSelection) {
    emit(state.copyWith(dateSelection: dateSelection));
  }

  void updateKindPersonalInfo(KindPersonalInfo? kindPersonalInfo) {
    emit(state.copyWith(kindPersonalInfo: kindPersonalInfo));
  }

  void updatePersonalInfo(PersonalInfo? personalInfo) {
    emit(state.copyWith(personalInfo: personalInfo));
  }

  void updateConfigApp({
    bool? isStartFixDate,
    bool? isBooking,
    bool? isDirectLinks,
    bool? isEmailExists,
    String? referenceBooking,
    SchoolInfo? schoolInfo,
  }) {
    emit(
      state.copyWith(
        configApp: state.configApp.copyWith(
          isStartFixDate: isStartFixDate ?? state.configApp.isStartFixDate,
          isBooking: isBooking ?? state.configApp.isBooking,
          isDirectLinks: isDirectLinks ?? state.configApp.isDirectLinks,
          isEmailExists: isEmailExists ?? state.configApp.isEmailExists,
          referenceBooking:
          referenceBooking ?? state.configApp.referenceBooking,
          schoolInfo: schoolInfo ?? state.configApp.schoolInfo,
        ),
      ),
    );
  }
}
