part of 'swim_level_bloc.dart';

abstract class SwimLevelEvent extends Equatable {
  const SwimLevelEvent();

  @override
  List<Object> get props => [];
}

class IsDirectLinks extends SwimLevelEvent {
  final bool isDirectLinks;
  const IsDirectLinks(this.isDirectLinks);

  @override
  List<Object> get props => [isDirectLinks];
}

class SwimLevelChanged extends SwimLevelEvent {
  final SwimLevelModel swimLevelModel;

  const SwimLevelChanged(this.swimLevelModel);

  @override
  List<Object> get props => [swimLevelModel];
}

class LoadSwimLevelOptions extends SwimLevelEvent {
  final List<SwimLevelRadioButton> swimLevelOptions;

  const LoadSwimLevelOptions(this.swimLevelOptions);

  @override
  List<Object> get props => [swimLevelOptions];
}

class SwimLevelRBChanged extends SwimLevelEvent {
  final String swimLevelName;
  final SwimLevelRadioButton swimLeveRB;

  const SwimLevelRBChanged(this.swimLevelName, this.swimLeveRB);

  @override
  List<Object> get props => [swimLevelName, swimLeveRB];
}

class SwimLevelOptionCheckboxChanged extends SwimLevelEvent {
  final SwimLevelRadioButton option;
  final bool isChecked;

  const SwimLevelOptionCheckboxChanged(this.option, this.isChecked);

  @override
  List<Object> get props => [option, isChecked];
}

class FormSubmitted extends SwimLevelEvent {}
