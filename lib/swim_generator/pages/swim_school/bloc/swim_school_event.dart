part of 'swim_school_bloc.dart';

abstract class SwimSchoolEvent extends Equatable {
  const SwimSchoolEvent();

  @override
  List<Object> get props => [];
}

class LoadSwimSchools extends SwimSchoolEvent {}

class SelectSwimSchool extends SwimSchoolEvent {
  final SwimSchool swimSchool;
  final String swimSchoolName;

  const SelectSwimSchool(
      this.swimSchool, this.swimSchoolName);

  @override
  List<Object> get props => [swimSchool, swimSchoolName];
}

class FormSubmitted extends SwimSchoolEvent {}

class FormCancelled extends SwimSchoolEvent {}
