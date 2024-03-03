part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  final List<ChildInfo> childInfos;
  final int childInfoIndex;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const KindPersonalInfoState({
    this.childInfos = const [ChildInfo()],
    this.childInfoIndex = 0,
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });


  KindPersonalInfoState copyWith({
    List<ChildInfo>? childInfos,
    int? childInfoIndex,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return KindPersonalInfoState(
      childInfos: childInfos ?? this.childInfos,
      childInfoIndex: childInfoIndex ?? this.childInfoIndex,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [childInfos, childInfoIndex, isValid, submissionStatus];
}


class ChildInfo {
  final FirstNameModel firstName;
  final LastNameModel lastName;
  final CheckboxModel isPhysicalDelay;
  final CheckboxModel isMentalDelay;
  final CheckboxModel isNoLimit;
  final List<String> kidsDevelopState;

  const ChildInfo({
    this.firstName = const FirstNameModel.pure(),
    this.lastName = const LastNameModel.pure(),
    this.isPhysicalDelay = const CheckboxModel.pure(),
    this.isMentalDelay = const CheckboxModel.pure(),
    this.isNoLimit = const CheckboxModel.pure(),
    this.kidsDevelopState = const [],
  });

  ChildInfo copyWith({
    FirstNameModel? firstName,
    LastNameModel? lastName,
    CheckboxModel? isPhysicalDelay,
    CheckboxModel? isMentalDelay,
    CheckboxModel? isNoLimit,
    List<String>? kidsDevelopState,
  }) {
    return ChildInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isPhysicalDelay: isPhysicalDelay ?? this.isPhysicalDelay,
      isMentalDelay: isMentalDelay ?? this.isMentalDelay,
      isNoLimit: isNoLimit ?? this.isNoLimit,
      kidsDevelopState: kidsDevelopState ?? this.kidsDevelopState,
    );
  }
}
