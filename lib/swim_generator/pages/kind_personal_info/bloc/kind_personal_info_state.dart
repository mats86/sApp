part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  final bool childFriendSelected;
  final ChildInfo childInfo;
  final CustomerInvitedInfo customerInvitedInfo;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;
  final FormzSubmissionStatus loadingStatus;
  final SwimCourseBookingByCode swimCourseBookingByCode;

  const KindPersonalInfoState({
    this.childFriendSelected = false,
    this.childInfo = const ChildInfo(),
    this.customerInvitedInfo = const CustomerInvitedInfo(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.loadingStatus = FormzSubmissionStatus.initial,
    this.swimCourseBookingByCode = const SwimCourseBookingByCode.empty(),
  });

  KindPersonalInfoState copyWith({
    bool? childFriendSelected,
    ChildInfo? childInfo,
    CustomerInvitedInfo? customerInvitedInfo,
    int? childInfoIndex,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
    FormzSubmissionStatus? loadingStatus,
    bool? isCodeLink,
    SwimCourseBookingByCode? swimCourseBookingByCode,
  }) {
    return KindPersonalInfoState(
      childFriendSelected: childFriendSelected ?? this.childFriendSelected,
      childInfo: childInfo ?? this.childInfo,
      customerInvitedInfo: customerInvitedInfo ?? this.customerInvitedInfo,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      swimCourseBookingByCode:
          swimCourseBookingByCode ?? this.swimCourseBookingByCode,
    );
  }

  @override
  List<Object> get props => [
        childFriendSelected,
        childInfo,
        customerInvitedInfo,
        isValid,
        submissionStatus,
        loadingStatus,
        swimCourseBookingByCode,
      ];
}

class ChildInfo {
  final FirstNameModel firstName;
  final LastNameModel lastName;
  final BirthDayModel birthDay;
  final CheckboxModel isPhysicalDelay;
  final CheckboxModel isMentalDelay;
  final CheckboxModel isNoLimit;
  final String kidsDevelopState;

  const ChildInfo({
    this.firstName = const FirstNameModel.pure(),
    this.lastName = const LastNameModel.pure(),
    this.birthDay = const BirthDayModel.pure(),
    this.isPhysicalDelay = const CheckboxModel.pure(),
    this.isMentalDelay = const CheckboxModel.pure(),
    this.isNoLimit = const CheckboxModel.pure(),
    this.kidsDevelopState = '',
  });

  ChildInfo copyWith({
    FirstNameModel? firstName,
    LastNameModel? lastName,
    BirthDayModel? birthDay,
    CheckboxModel? isPhysicalDelay,
    CheckboxModel? isMentalDelay,
    CheckboxModel? isNoLimit,
    String? kidsDevelopState,
  }) {
    return ChildInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDay: birthDay ?? this.birthDay,
      isPhysicalDelay: isPhysicalDelay ?? this.isPhysicalDelay,
      isMentalDelay: isMentalDelay ?? this.isMentalDelay,
      isNoLimit: isNoLimit ?? this.isNoLimit,
      kidsDevelopState: kidsDevelopState ?? this.kidsDevelopState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentFirstName': firstName.value,
      'studentLastName': lastName.value,
      'studentBirthDate': birthDay.value?.toIso8601String(),
      'isPhysicalDelay': isPhysicalDelay.value,
      'isMentalDelay': isMentalDelay.value,
      'isNoLimit': isNoLimit.value,
      'kidsDevelopState': kidsDevelopState,
    };
  }
}

class CustomerInvitedInfo {
  final FirstNameModel customerInvitedFirstName;
  final LastNameModel customerInvitedLastName;
  final PhoneNumberModel customerInvitedPhoneNumber;
  final EmailModel customerInvitedEmail;

  const CustomerInvitedInfo({
    this.customerInvitedFirstName = const FirstNameModel.pure(),
    this.customerInvitedLastName = const LastNameModel.pure(),
    this.customerInvitedPhoneNumber = const PhoneNumberModel.pure(),
    this.customerInvitedEmail = const EmailModel.pure(),
  });

  CustomerInvitedInfo copyWith({
    FirstNameModel? customerInvitedFirstName,
    LastNameModel? customerInvitedLastName,
    PhoneNumberModel? customerInvitedPhoneNumber,
    EmailModel? customerInvitedEmail,
  }) {
    return CustomerInvitedInfo(
      customerInvitedFirstName:
          customerInvitedFirstName ?? this.customerInvitedFirstName,
      customerInvitedLastName:
          customerInvitedLastName ?? this.customerInvitedLastName,
      customerInvitedPhoneNumber:
          customerInvitedPhoneNumber ?? this.customerInvitedPhoneNumber,
      customerInvitedEmail: customerInvitedEmail ?? this.customerInvitedEmail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerInvitedFirstName': customerInvitedFirstName.value,
      'customerInvitedLastName': customerInvitedLastName.value,
      'customerInvitedPhoneNumber': customerInvitedPhoneNumber.value,
      'customerInvitedEmail': customerInvitedEmail.value,
    };
  }
}
