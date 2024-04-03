import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/config_app.dart';
import 'package:swim_generator_app/swim_generator/models/date_selection.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/models/swim_season_info.dart';
import 'package:swim_generator_app/swim_generator/pages/kind_personal_info/bloc/kind_personal_info_bloc.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_school/models/swim_school.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';

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

  void updateNumberStepper(int length) {
    List<int> steps = List.generate(length, (index) => index + 1);
    emit(state.copyWith(numberStepper: steps));
  }

  void customizeSteps(bool isAdultCourse, bool isMultiBooking) {
    List<StepPage> stepPages = List<StepPage>.from(state.stepPages);

    if (isAdultCourse) {
      stepPages.removeWhere((element) => element == StepPage.kindPersonalInfo);
    }

    if (isAdultCourse && isMultiBooking) {
      stepPages.add(StepPage.kindPersonalInfo);
      stepPages.sort((a, b) => a.index.compareTo(b.index));
    }
    List<int> steps = List.generate(stepPages.length, (index) => index + 1);

    emit(state.copyWith(
        stepPages: stepPages,
        numberStepper: steps,
        stepperLength: stepPages.length));
  }

  void updateStepPages(List<StepPage> stepPages) {
    emit(state.copyWith(stepPages: stepPages));
  }

  void updateAddStepPages(int addStep) {
    List<StepPage> stepPages = state.stepPages;
    int index = state.stepPages.indexOf(StepPage.kindPersonalInfo);
    if (index != -1) {
      for (int i = 0; i < addStep - 1; i++) {
        stepPages.insert(index + 1, StepPage.kindPersonalInfo);
      }
    }
    emit(
      state.copyWith(
        childInfoLength: addStep,
        stepPages: stepPages,
        kindPersonalInfo: state.kindPersonalInfo.copyWith(
          childInfos: List.filled(addStep, const ChildInfo()),
          customerInvitedInfos:
              List.filled(addStep, const CustomerInvitedInfo()),
        ),
      ),
    );
  }

  void updateSwimSchool(SwimSchool? swimSchool) {
    emit(state.copyWith(swimSchool: swimSchool));
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

  void childInfoIndexContinued(bool childFriendStep) {
    if (state.childInfoIndex < state.childInfoLength - 1) {
      emit(
        state.copyWith(
          childInfoIndex: state.childInfoIndex + 1,
          activeChildPageIndex: !childFriendStep
              ? state.childInfoIndex + 1
              : state.childInfoIndex,
          activeGuardianPageIndex: childFriendStep
              ? state.activeGuardianPageIndex + 1
              : state.activeGuardianPageIndex,
        ),
      );
    }
  }

  void childInfoIndexCancelled() {
    if (state.childInfoIndex > 0) {
      emit(state.copyWith(
        childInfoIndex: state.childInfoIndex - 1,
      ));
    }
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
    bool? isCodeLinks,
    String? code,
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
          code: code ?? state.configApp.code,
          isCodeLinks: isCodeLinks ?? state.configApp.isCodeLinks,
          isEmailExists: isEmailExists ?? state.configApp.isEmailExists,
          referenceBooking:
              referenceBooking ?? state.configApp.referenceBooking,
          schoolInfo: schoolInfo ?? state.configApp.schoolInfo,
        ),
      ),
    );
  }

  void removeEmptyChildInfoAndCustomerInvitedInfo() {
    final updatedChildInfos = state.kindPersonalInfo.childInfos
        .where((childInfo) => childInfo.firstName.value.isNotEmpty)
        .toList();
    final updatedCustomerInvitedInfo = state
        .kindPersonalInfo.customerInvitedInfos
        .where(
            (childInfo) => childInfo.customerInvitedFirstName.value.isNotEmpty)
        .toList();
    emit(state.copyWith(
        kindPersonalInfo: state.kindPersonalInfo.copyWith(
            childInfosNoEmpty: updatedChildInfos,
            customerInvitedInfosNoEmpty: updatedCustomerInvitedInfo)));
  }
}
