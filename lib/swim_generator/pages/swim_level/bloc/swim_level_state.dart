part of 'swim_level_bloc.dart';

class SwimLevelState extends Equatable {
  const SwimLevelState({
    this.isDirectLinks = false,
    this.swimLevelModel = const SwimLevelModel.pure(),
    this.swimLevelOptions = const [],
    this.swimLevelRB = const SwimLevelRBModel.pure(),
    this.selectedSeimLevelRB = const SwimLevelRadioButton.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool isDirectLinks;
  final SwimLevelModel swimLevelModel;
  final List<SwimLevelRadioButton> swimLevelOptions;
  final SwimLevelRBModel swimLevelRB;
  final SwimLevelRadioButton selectedSeimLevelRB;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimLevelState copyWith({
    bool? isDirectLinks,
    SwimLevelModel? swimLevelModel,
    List<SwimLevelRadioButton>? swimLevelOptions,
    SwimLevelRBModel? swimLevelRB,
    SwimLevelRadioButton? selectedSeimLevelRB,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimLevelState(
      isDirectLinks: isDirectLinks ?? this.isDirectLinks,
      swimLevelModel: swimLevelModel ?? this.swimLevelModel,
      swimLevelOptions: swimLevelOptions ?? this.swimLevelOptions,
      swimLevelRB: swimLevelRB ?? this.swimLevelRB,
      selectedSeimLevelRB: selectedSeimLevelRB ?? this.selectedSeimLevelRB,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
    isDirectLinks,
    swimLevelModel,
    swimLevelOptions,
    swimLevelRB,
    selectedSeimLevelRB,
    submissionStatus,
  ];
}
