part of 'swim_level_bloc.dart';

class SwimLevelState extends Equatable {
  const SwimLevelState({
    this.swimLevelModel = const SwimLevelModel.pure(),
    this.swimLevelOptions = const [],
    this.swimLevelRB = const SwimLevelRBModel.pure(),
    this.selectedSwimLevelRB = const SwimLevelRadioButton.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final SwimLevelModel swimLevelModel;
  final List<SwimLevelRadioButton> swimLevelOptions;
  final SwimLevelRBModel swimLevelRB;
  final SwimLevelRadioButton selectedSwimLevelRB;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimLevelState copyWith({
    SwimLevelModel? swimLevelModel,
    List<SwimLevelRadioButton>? swimLevelOptions,
    SwimLevelRBModel? swimLevelRB,
    SwimLevelRadioButton? selectedSwimLevelRB,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimLevelState(
      swimLevelModel: swimLevelModel ?? this.swimLevelModel,
      swimLevelOptions: swimLevelOptions ?? this.swimLevelOptions,
      swimLevelRB: swimLevelRB ?? this.swimLevelRB,
      selectedSwimLevelRB: selectedSwimLevelRB ?? this.selectedSwimLevelRB,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
    swimLevelModel,
    swimLevelOptions,
    swimLevelRB,
    selectedSwimLevelRB,
    submissionStatus,
  ];
}
