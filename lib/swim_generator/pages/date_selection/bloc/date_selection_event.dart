part of 'date_selection_bloc.dart';

abstract class DateSelectionEvent extends Equatable {
  const DateSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadFixDates extends DateSelectionEvent {
  final int swimCourseID;
  final List<int> swimPoolIDs;

  const LoadFixDates(this.swimCourseID, this.swimPoolIDs);

  @override
  List<Object> get props => [swimCourseID, swimPoolIDs];
}

class FixDateChanged extends DateSelectionEvent {
  final int fixDateName;
  final FixDate fixDate;
  const FixDateChanged(this.fixDateName, this.fixDate);

  @override
  List<Object> get props => [fixDateName, fixDate];
}

class UpdateHasFixedDesiredDate extends DateSelectionEvent {
  final bool hasFixedDesiredDate;
  const UpdateHasFixedDesiredDate(this.hasFixedDesiredDate);

  @override
  List<Object> get props => [hasFixedDesiredDate];
}

class SelectFlexDate extends DateSelectionEvent {}

class SelectFixDate extends DateSelectionEvent {
  final int? bookingDateTypID;

  const SelectFixDate({this.bookingDateTypID});
}

class UpdateDateTime1 extends DateSelectionEvent {
  final DateTime? date;
  final TimeOfDay? time;

  const UpdateDateTime1({this.date, this.time});
}

class UpdateDateTime2 extends DateSelectionEvent {
  final DateTime? date;
  final TimeOfDay? time;

  const UpdateDateTime2({this.date, this.time});
}

class UpdateDateTime3 extends DateSelectionEvent {
  final DateTime? date;
  final TimeOfDay? time;

  const UpdateDateTime3({this.date, this.time});
}

class FormSubmitted extends DateSelectionEvent {}
