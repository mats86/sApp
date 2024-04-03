part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.stepperLength = 0,
    this.activeStepperIndex = 0,
    this.numberStepper = const [],
    this.stepPages = const [],
    this.swimSchool = const SwimSchool.empty(),
    this.swimLevel = const SwimLevel.empty(),
    this.swimSeasonInfo = const SwimSeasonInfo.empty(),
    this.birthDay = const BirthDay.empty(),
    this.swimCourseInfo = const SwimCourseInfo.empty(),
    this.swimPools = const [],
    this.dateSelection = const DateSelection.empty(),
    this.childInfoLength = 0,
    this.childInfoIndex = 0,
    this.activeChildPageIndex = 0,
    this.activeGuardianPageIndex = 0,
    this.kindPersonalInfo = const KindPersonalInfo.empty(),
    this.personalInfo = const PersonalInfo.empty(),
    this.configApp = const ConfigApp.empty(),
  });

  final int stepperLength;
  final int activeStepperIndex;
  final List<int> numberStepper;
  final List<StepPage> stepPages;
  final SwimSchool swimSchool;
  final SwimLevel swimLevel;
  final SwimSeasonInfo swimSeasonInfo;
  final BirthDay birthDay;
  final SwimCourseInfo swimCourseInfo;
  final List<SwimPoolInfo> swimPools;
  final DateSelection dateSelection;
  final int childInfoLength;
  final int childInfoIndex;
  final int activeChildPageIndex;
  final int activeGuardianPageIndex;
  final KindPersonalInfo kindPersonalInfo;
  final PersonalInfo personalInfo;
  final ConfigApp configApp;

  SwimGeneratorState copyWith({
    int? stepperLength,
    int? activeStepperIndex,
    List<int>? numberStepper,
    List<StepPage>? stepPages,
    SwimSchool? swimSchool,
    List<bool>? shouldUseFutureBuilderList,
    SwimLevel? swimLevel,
    SwimSeasonInfo? swimSeasonInfo,
    BirthDay? birthDay,
    SwimCourseInfo? swimCourseInfo,
    List<SwimPoolInfo>? swimPools,
    DateSelection? dateSelection,
    int? childInfoLength,
    int? childInfoIndex,
    int? activeChildPageIndex,
    int? activeGuardianPageIndex,
    KindPersonalInfo? kindPersonalInfo,
    PersonalInfo? personalInfo,
    bool? isEmailExists,
    ConfigApp? configApp,
  }) {
    return SwimGeneratorState(
      stepperLength: stepperLength ?? this.stepperLength,
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      numberStepper: numberStepper ?? this.numberStepper,
      stepPages: stepPages ?? this.stepPages,
      swimSchool: swimSchool ?? this.swimSchool,
      swimLevel: swimLevel ?? this.swimLevel,
      swimSeasonInfo: swimSeasonInfo ?? this.swimSeasonInfo,
      birthDay: birthDay ?? this.birthDay,
      swimCourseInfo: swimCourseInfo ?? this.swimCourseInfo,
      swimPools: swimPools ?? this.swimPools,
      dateSelection: dateSelection ?? this.dateSelection,
      childInfoLength: childInfoLength ?? this.childInfoLength,
      childInfoIndex: childInfoIndex ?? this.childInfoIndex,
      activeChildPageIndex: activeChildPageIndex ?? this.activeChildPageIndex,
      activeGuardianPageIndex:
          activeGuardianPageIndex ?? this.activeGuardianPageIndex,
      kindPersonalInfo: kindPersonalInfo ?? this.kindPersonalInfo,
      personalInfo: personalInfo ?? this.personalInfo,
      configApp: configApp ?? this.configApp,
    );
  }

  @override
  List<Object> get props => [
        stepperLength,
        activeStepperIndex,
        numberStepper,
        stepPages,
        swimSchool,
        swimLevel,
        swimSeasonInfo,
        birthDay,
        swimCourseInfo,
        swimPools,
        dateSelection,
        childInfoLength,
        childInfoIndex,
        activeChildPageIndex,
        activeGuardianPageIndex,
        kindPersonalInfo,
        personalInfo,
        configApp,
      ];
}
