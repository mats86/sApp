part of 'swim_pool_bloc.dart';

abstract class SwimPoolEvent extends Equatable {
  const SwimPoolEvent();

  @override
  List<Object> get props => [];
}

class SwimPoolLoading extends SwimPoolEvent {
  final bool isBooking;
  const SwimPoolLoading(this.isBooking);

  @override
  List<Object> get props => [isBooking];
}

class LoadSwimPools extends SwimPoolEvent {
  final int swimCourseID;
  const LoadSwimPools(this.swimCourseID);

  @override
  List<Object> get props => [swimCourseID];
}

class SwimPoolOptionToggled extends SwimPoolEvent {
  final int index;
  final bool isSelected;

  const SwimPoolOptionToggled(this.index, this.isSelected);
}

class SwimPoolModelsChanged extends SwimPoolEvent {
  final List<SwimPool> swimPools;

  const SwimPoolModelsChanged(this.swimPools);
}

class FormSubmitted extends SwimPoolEvent {}
