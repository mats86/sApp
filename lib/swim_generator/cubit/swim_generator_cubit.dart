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
  SwimGeneratorCubit() : super(const SwimGeneratorState());

  void stepTapped(int tappedIndex) {
    emit(SwimGeneratorState(
      activeStepperIndex: tappedIndex,
    ));
  }

  void stepContinued() {
    if (state.activeStepperIndex < state.stepperLength - 1) {
      emit(
        state.copyWith(
          activeStepperIndex: state.activeStepperIndex + 1,
        ),
      );
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
      ));
    }
  }

  void updateStepperLength(int stepperLength) {
    emit(state.copyWith(stepperLength: stepperLength));
  }

  void updateNumberStepper(int length, {int addStep = 0}) {
    List<int> steps = List.generate(length, (index) => index + 1);
    emit(state.copyWith(numberStepper: steps));
  }

  void removeLastStep() {
    List<int> steps = List<int>.from(state.numberStepper);
    if (steps.isNotEmpty) {
      steps.removeLast();
    }
    emit(state.copyWith(numberStepper: steps));
  }

  void updateStepPages(List<int> stepPages) {
    emit(state.copyWith(stepPages: stepPages));
  }

  void updateAddStepPages(int addStep) {
    List<int> stepPages = state.stepPages;
    int index = state.stepPages.indexOf(6);
    if (index != -1) {
      for (int i = 0; i < addStep - 1; i++) {
        stepPages.insert(index + 1, 6);
      }
    }
    emit(state.copyWith(stepPages: stepPages));
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

  void updateKindPersonalInfo(List<KindPersonalInfo>? kindPersonalInfos) {
    emit(state.copyWith(kindPersonalInfos: kindPersonalInfos));
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
