part of 'swim_course_bloc.dart';

abstract class SwimCourseEvent extends Equatable {
  const SwimCourseEvent();

  @override
  List<Object> get props => [];
}

class SwimCourseChanged extends SwimCourseEvent {
  final String swimCourse;
  final SwimCourse course;

  const SwimCourseChanged(this.swimCourse, this.course);

  @override
  List<Object> get props => [swimCourse, course];
}

class SwimSeasonChanged extends SwimCourseEvent {
  final String swimSeason;

  const SwimSeasonChanged(this.swimSeason);

  @override
  List<Object> get props => [swimSeason];
}

class LoadSwimSeasonOptions extends SwimCourseEvent {}

class LoadSwimCourseOptions extends SwimCourseEvent {
  final SwimLevelEnum swimLevel;
  final DateTime birthDay;
  final DateTime refDate;

  const LoadSwimCourseOptions(this.swimLevel, this.birthDay, this.refDate);

  @override
  List<Object> get props => [swimLevel, birthDay, refDate];
}

class ActiveMultiChild extends SwimCourseEvent {}

class UpdateIsForMultiChild extends SwimCourseEvent {
  final bool isForMultiChild;

  const UpdateIsForMultiChild(this.isForMultiChild);

  @override
  List<Object> get props => [
        isForMultiChild,
      ];
}

class DropdownChanged extends SwimCourseEvent {
  final int dropdownValue;

  const DropdownChanged(this.dropdownValue);

  @override
  List<Object> get props => [dropdownValue];
}

class WebPageLoading extends SwimCourseEvent {}

class WebPageLoaded extends SwimCourseEvent {}

class FormSubmitted extends SwimCourseEvent {}
