part of 'db_swim_course_bloc.dart';

abstract class DbSwimCourseEvent extends Equatable {
  const DbSwimCourseEvent();

  @override
  List<Object> get props => [];
}

class LoadSwimCourseOptions extends DbSwimCourseEvent {}
