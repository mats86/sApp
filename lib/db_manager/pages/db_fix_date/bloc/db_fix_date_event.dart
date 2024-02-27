part of 'db_fix_date_bloc.dart';

abstract class DbFixDateEvent extends Equatable {
  const DbFixDateEvent();

  @override
  List<Object> get props => [];
}

class LoadFixDateOptions extends DbFixDateEvent {}

class LoadSwimCourseOptions extends DbFixDateEvent {}
