part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
    this.isAdultCourse = false,
    this.swimLevel = const SwimLevel.empty(),
    this.swimSeasonInfo = const SwimSeasonInfo.empty(),
    this.birthDay = const BirthDay.empty(),
    this.swimCourseInfo = const SwimCourseInfo.empty(),
    this.swimPools = const [],
    this.dateSelection = const DateSelection.empty(),
    this.kindPersonalInfo = const KindPersonalInfo.empty(),
    this.personalInfo = const PersonalInfo.empty(),
    this.configApp = const ConfigApp.empty(),
  });

  final int activeStepperIndex;
  final bool isAdultCourse;
  final SwimLevel swimLevel;
  final SwimSeasonInfo swimSeasonInfo;
  final BirthDay birthDay;
  final SwimCourseInfo swimCourseInfo;
  final List<SwimPoolInfo> swimPools;
  final DateSelection dateSelection;
  final KindPersonalInfo kindPersonalInfo;
  final PersonalInfo personalInfo;
  final ConfigApp configApp;

  SwimGeneratorState copyWith({
    int? activeStepperIndex,
    bool? isAdultCourse,
    List<bool>? shouldUseFutureBuilderList,
    SwimLevel? swimLevel,
    SwimSeasonInfo? swimSeasonInfo,
    BirthDay? birthDay,
    SwimCourseInfo? swimCourseInfo,
    List<SwimPoolInfo>? swimPools,
    DateSelection? dateSelection,
    KindPersonalInfo? kindPersonalInfo,
    PersonalInfo? personalInfo,
    bool? isEmailExists,
    ConfigApp? configApp,
  }) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      isAdultCourse: isAdultCourse ?? this.isAdultCourse,
      swimLevel: swimLevel ?? this.swimLevel,
      swimSeasonInfo: swimSeasonInfo ?? this.swimSeasonInfo,
      birthDay: birthDay ?? this.birthDay,
      swimCourseInfo: swimCourseInfo ?? this.swimCourseInfo,
      swimPools: swimPools ?? this.swimPools,
      dateSelection: dateSelection ?? this.dateSelection,
      kindPersonalInfo: kindPersonalInfo ?? this.kindPersonalInfo,
      personalInfo: personalInfo ?? this.personalInfo,
      configApp: configApp ?? this.configApp,
    );
  }

  @override
  List<Object> get props => [
    activeStepperIndex,
    isAdultCourse,
    swimLevel,
    swimSeasonInfo,
    birthDay,
    swimCourseInfo,
    swimPools,
    dateSelection,
    kindPersonalInfo,
    personalInfo,
    configApp,
  ];
}
