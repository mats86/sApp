part of 'birth_day_bloc.dart';

abstract class BirthDayEvent extends Equatable {
  const BirthDayEvent();

  @override
  List<Object> get props => [];
}

class BirthDayChanged extends BirthDayEvent {
  final DateTime birthDay;
  const BirthDayChanged(this.birthDay);

  @override
  List<Object> get props => [birthDay];
}

class CancelAlert extends BirthDayEvent {}

class FormSubmitted extends BirthDayEvent {
  final int swimCourseID;
  final bool isDirectLinks;
  const FormSubmitted(this.swimCourseID, this.isDirectLinks);

  @override
  List<Object> get props => [swimCourseID, isDirectLinks];
}