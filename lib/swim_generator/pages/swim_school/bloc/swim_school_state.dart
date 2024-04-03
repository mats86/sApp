part of 'swim_school_bloc.dart';

class SwimSchoolState extends Equatable {
  const SwimSchoolState({
    this.availableSchools = const [],
    this.swimSchool = const SwimSchool.empty(),
    this.swimSchoolUrl = '',
    this.swimSchoolSelected = const SwimSchoolModel.pure(),
    this.isValid = false,
    this.loadingSwimSchoolStatus = FormzSubmissionStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.cancellationStatus = FormzSubmissionStatus.initial,
  });

  final List<SwimSchool> availableSchools;
  final SwimSchool swimSchool;
  final String swimSchoolUrl;
  final SwimSchoolModel swimSchoolSelected;
  final bool isValid;
  final FormzSubmissionStatus loadingSwimSchoolStatus;
  final FormzSubmissionStatus submissionStatus;
  final FormzSubmissionStatus cancellationStatus;

  SwimSchoolState copyWith({
    List<SwimSchool>? availableSchools,
    SwimSchool? swimSchool,
    String? swimSchoolUrl,
    SwimSchoolModel? swimSchoolSelected,
    bool? isValid,
    FormzSubmissionStatus? loadingSwimSchoolStatus,
    FormzSubmissionStatus? submissionStatus,
    FormzSubmissionStatus? cancellationStatus,
  }) {
    return SwimSchoolState(
      availableSchools: availableSchools ?? this.availableSchools,
      swimSchool: swimSchool ?? this.swimSchool,
      swimSchoolUrl: swimSchoolUrl ?? this.swimSchoolUrl,
      swimSchoolSelected: swimSchoolSelected ?? this.swimSchoolSelected,
      isValid: isValid ?? this.isValid,
      loadingSwimSchoolStatus:
          loadingSwimSchoolStatus ?? this.loadingSwimSchoolStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      cancellationStatus: cancellationStatus ?? this.cancellationStatus,
    );
  }

  @override
  List<Object?> get props => [
        availableSchools,
        swimSchool,
        swimSchoolUrl,
        swimSchoolSelected,
        isValid,
        loadingSwimSchoolStatus,
        submissionStatus,
        cancellationStatus,
      ];
}
