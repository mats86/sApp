part of 'birth_day_bloc.dart';

class BirthDayState extends Equatable {
  const BirthDayState({
    this.birthDay = const BirthDayModel.pure(),
    this.autoSelectedCourse = const SwimCourse.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final BirthDayModel birthDay;
  final SwimCourse autoSelectedCourse;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  BirthDayState copyWith({
    BirthDayModel? birthDay,
    SwimCourse? autoSelectedCourse,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return BirthDayState(
      birthDay: birthDay ?? this.birthDay,
      autoSelectedCourse: autoSelectedCourse ?? this.autoSelectedCourse,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props =>
      [birthDay, autoSelectedCourse, submissionStatus,];
}
