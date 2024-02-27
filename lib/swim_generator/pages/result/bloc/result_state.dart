part of 'result_bloc.dart';

class ResultState extends Equatable {
  const ResultState({
    this.isBooking = false,
    this.isConfirmed = const CheckboxModel.pure(),
    this.isCancellation = const CheckboxModel.pure(),
    this.isConsentGDPR = const CheckboxModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool isBooking;
  final CheckboxModel isConfirmed;
  final CheckboxModel isCancellation;
  final CheckboxModel isConsentGDPR;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  ResultState copyWith({
    bool? isBooking,
    CheckboxModel? isConfirmed,
    CheckboxModel? isCancellation,
    CheckboxModel? isConsentGDPR,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ResultState(
        isBooking: isBooking ?? this.isBooking,
        isConfirmed: isConfirmed ?? this.isConfirmed,
        isCancellation: isCancellation ?? this.isCancellation,
        isConsentGDPR: isConsentGDPR ?? this.isConsentGDPR,
        isValid: isValid ?? this.isValid,
        submissionStatus: submissionStatus ?? this.submissionStatus);
  }

  @override
  List<Object> get props =>
      [isBooking, isConfirmed, isCancellation, isConsentGDPR, submissionStatus];
}
