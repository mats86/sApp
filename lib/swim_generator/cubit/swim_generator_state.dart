part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.stepperLength = 0,
    this.activeStepperIndex = 0,
    this.numberStepper = const [],
    this.stepPages = const [],
    this.swimLevel = const SwimLevel.empty(),
    this.swimSeasonInfo = const SwimSeasonInfo.empty(),
    this.birthDay = const BirthDay.empty(),
    this.swimCourseInfo = const SwimCourseInfo.empty(),
    this.swimPools = const [],
    this.dateSelection = const DateSelection.empty(),
    this.kindPersonalInfos = const [],
    this.personalInfo = const PersonalInfo.empty(),
    this.configApp = const ConfigApp.empty(),
  });

  final int stepperLength;
  final int activeStepperIndex;
  final List<int> numberStepper;
  final List<int> stepPages;
  final SwimLevel swimLevel;
  final SwimSeasonInfo swimSeasonInfo;
  final BirthDay birthDay;
  final SwimCourseInfo swimCourseInfo;
  final List<SwimPoolInfo> swimPools;
  final DateSelection dateSelection;
  final List<KindPersonalInfo> kindPersonalInfos;
  final PersonalInfo personalInfo;
  final ConfigApp configApp;

  SwimGeneratorState copyWith({
    int? stepperLength,
    int? activeStepperIndex,
    List<int>? numberStepper,
    List<int>? stepPages,
    List<bool>? shouldUseFutureBuilderList,
    SwimLevel? swimLevel,
    SwimSeasonInfo? swimSeasonInfo,
    BirthDay? birthDay,
    SwimCourseInfo? swimCourseInfo,
    List<SwimPoolInfo>? swimPools,
    DateSelection? dateSelection,
    List<KindPersonalInfo>? kindPersonalInfos,
    PersonalInfo? personalInfo,
    bool? isEmailExists,
    ConfigApp? configApp,
  }) {
    return SwimGeneratorState(
      stepperLength: stepperLength ?? this.stepperLength,
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      numberStepper: numberStepper ?? this.numberStepper,
      stepPages: stepPages ?? this.stepPages,
      swimLevel: swimLevel ?? this.swimLevel,
      swimSeasonInfo: swimSeasonInfo ?? this.swimSeasonInfo,
      birthDay: birthDay ?? this.birthDay,
      swimCourseInfo: swimCourseInfo ?? this.swimCourseInfo,
      swimPools: swimPools ?? this.swimPools,
      dateSelection: dateSelection ?? this.dateSelection,
      kindPersonalInfos: kindPersonalInfos ?? this.kindPersonalInfos,
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
    swimLevel,
    swimSeasonInfo,
    birthDay,
    swimCourseInfo,
    swimPools,
    dateSelection,
    kindPersonalInfos,
    personalInfo,
    configApp,
  ];
}
