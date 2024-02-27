part of 'swim_season_bloc.dart';

abstract class SwimSeasonEvent extends Equatable {
  const SwimSeasonEvent();

  @override
  List<Object> get props => [];
}

class LoadSwimSeasonOptions extends SwimSeasonEvent {
  final List<SwimSeason> swimSeasonOptions;

  const LoadSwimSeasonOptions(this.swimSeasonOptions);

  @override
  List<Object> get props => [swimSeasonOptions];
}

class SwimSeasonChanged extends SwimSeasonEvent {
  final String swimSeasonName;
  final SwimSeason season;

  const SwimSeasonChanged(this.swimSeasonName, this.season);

  @override
  List<Object> get props => [swimSeasonName, season];
}

class FormSubmitted extends SwimSeasonEvent {}
