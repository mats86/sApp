part of 'db_swim_course_bloc.dart';

class DbSwimCourseState extends Equatable {
  const DbSwimCourseState({
    this.swimCourseOptions = const [],
    this.loadingCourseStatus = FormzSubmissionStatus.initial,
  });

  final List<SwimCourse> swimCourseOptions;
  final FormzSubmissionStatus loadingCourseStatus;

  DbSwimCourseState copyWith({
    List<SwimCourse>? swimCourseOptions,
    FormzSubmissionStatus? loadingCourseStatus,
  }) {
    return DbSwimCourseState(
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
    );
  }

  @override
  List<Object?> get props => [swimCourseOptions, loadingCourseStatus];
}
