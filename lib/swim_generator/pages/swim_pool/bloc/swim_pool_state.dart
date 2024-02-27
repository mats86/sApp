part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final bool isBooking;
  final List<SwimPool> swimPools;
  final FormzSubmissionStatus loadingStatus;
  final FormzSubmissionStatus toggleStatus;
  final SwimPoolModel swimPoolModel;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const SwimPoolState({
    this.isBooking = false,
    this.swimPools = const [],
    this.loadingStatus = FormzSubmissionStatus.initial,
    this.toggleStatus = FormzSubmissionStatus.initial,
    this.swimPoolModel = const SwimPoolModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  SwimPoolState copyWith({
    bool? isBooking,
    List<SwimPool>? swimPools,
    FormzSubmissionStatus? loadingStatus,
    FormzSubmissionStatus? toggleStatus,
    SwimPoolModel? swimPoolModel,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimPoolState(
      isBooking: isBooking ?? this.isBooking,
      swimPools: swimPools ?? this.swimPools,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      swimPoolModel: swimPoolModel ?? this.swimPoolModel,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        isBooking,
        swimPools,
        loadingStatus,
        toggleStatus,
        swimPoolModel,
        submissionStatus
      ];
}
