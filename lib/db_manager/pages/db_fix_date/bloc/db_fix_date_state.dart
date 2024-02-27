part of 'db_fix_date_bloc.dart';

class DbFixDateState extends Equatable {
  const DbFixDateState({
    this.fixDateOptions = const [],
    this.loadingFixDateStatus = FormzSubmissionStatus.initial,
    this.swimCourseOptions = const [],
    this.loadingCourseStatus = FormzSubmissionStatus.initial,
  });

  final List<FixDateDetail> fixDateOptions;
  final FormzSubmissionStatus loadingFixDateStatus;
  final List<SwimCourse> swimCourseOptions;
  final FormzSubmissionStatus loadingCourseStatus;

  DbFixDateState copyWith({
    List<FixDateDetail>? fixDateOptions,
    FormzSubmissionStatus? loadingFixDateStatus,
    List<SwimCourse>? swimCourseOptions,
    FormzSubmissionStatus? loadingCourseStatus,
  }) {
    return DbFixDateState(
      fixDateOptions: fixDateOptions ?? this.fixDateOptions,
      loadingFixDateStatus: loadingFixDateStatus ?? this.loadingFixDateStatus,
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
    );
  }

  @override
  List<Object?> get props => [
    fixDateOptions,
    loadingFixDateStatus,
    swimCourseOptions,
    loadingCourseStatus,
  ];
}
