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

class UpdateSelectedDates extends DateSelectionEvent {
  final List<DateTime> selectedDates;

  const UpdateSelectedDates(
      {required this.selectedDates});

  @override
  List<Object> get props => [selectedDates];
}

class UpdateSelectedTimes extends DateSelectionEvent {
  final TimeOfDay selectedTime;
  final int index;

  const UpdateSelectedTimes(
      {required this.index, required this.selectedTime,});
  @override
  List<Object> get props => [index, selectedTime];
}

class UpdateSelectedDateTimeLength extends DateSelectionEvent {
  final int selectedDateTimeLength;

  const UpdateSelectedDateTimeLength({required this.selectedDateTimeLength});

  @override
  List<Object> get props => [selectedDateTimeLength];
}
class UpdateIsValid extends DateSelectionEvent {}
class FormSubmitted extends DateSelectionEvent {}
