part of 'swim_season_bloc.dart';

class SwimSeasonState extends Equatable {
  const SwimSeasonState({
    this.swimSeasonOptions = const [],
    this.swimSeason = const SwimSeasonModel.pure(),
    this.selectedSwimSeason = const SwimSeason.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final List<SwimSeason> swimSeasonOptions;
  final SwimSeasonModel swimSeason;
  final SwimSeason selectedSwimSeason;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimSeasonState copyWith({
    List<SwimSeason>? swimSeasonOptions,
    SwimSeasonModel? swimSeason,
    SwimSeason? selectedSwimSeason,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimSeasonState(
      swimSeasonOptions: swimSeasonOptions ?? this.swimSeasonOptions,
      swimSeason: swimSeason ?? this.swimSeason,
      selectedSwimSeason: selectedSwimSeason ?? this.selectedSwimSeason,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
    swimSeasonOptions,
    swimSeason,
    selectedSwimSeason,
    submissionStatus,
  ];
}
