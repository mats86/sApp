part of 'swim_course_bloc.dart';

class SwimCourseState extends Equatable {
  const SwimCourseState({
    this.swimSeasons = const [],
    this.swimSeason = const SwimSeasonModel.pure(),
    this.swimCourseOptions = const [],
    this.swimCourse = const SwimCourseModel.pure(),
    this.selectedCourse = const SwimCourse.empty(),
    this.isValid = false,
    this.loadingSeasonStatus = FormzSubmissionStatus.initial,
    this.loadingCourseStatus = FormzSubmissionStatus.initial,
    this.loadingWebPageStatus = FormzSubmissionStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final List<String> swimSeasons;
  final SwimSeasonModel swimSeason;
  final List<SwimCourse> swimCourseOptions;
  final SwimCourseModel swimCourse;
  final SwimCourse selectedCourse;
  final bool isValid;
  final FormzSubmissionStatus loadingSeasonStatus;
  final FormzSubmissionStatus loadingCourseStatus;
  final FormzSubmissionStatus loadingWebPageStatus;
  final FormzSubmissionStatus submissionStatus;

  SwimCourseState copyWith({
    List<String>? swimSeasons,
    SwimSeasonModel? swimSeason,
    List<SwimCourse>? swimCourseOptions,
    SwimCourseModel? swimCourse,
    SwimCourse? selectedCourse,
    bool? isValid,
    FormzSubmissionStatus? loadingSeasonStatus,
    FormzSubmissionStatus? loadingCourseStatus,
    FormzSubmissionStatus? loadingWebPageStatus,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimCourseState(
      swimSeasons: swimSeasons ?? this.swimSeasons,
      swimSeason: swimSeason ?? this.swimSeason,
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      swimCourse: swimCourse ?? this.swimCourse,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      isValid: isValid ?? this.isValid,
      loadingSeasonStatus: loadingSeasonStatus ?? this.loadingSeasonStatus,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
      loadingWebPageStatus: loadingWebPageStatus ?? this.loadingWebPageStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    swimSeasons,
    swimSeason,
    swimCourseOptions,
    swimCourse,
    loadingSeasonStatus,
    loadingCourseStatus,
    loadingWebPageStatus,
    submissionStatus,
  ];
}
