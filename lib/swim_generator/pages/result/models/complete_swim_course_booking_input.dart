import '../../kind_personal_info/bloc/kind_personal_info_bloc.dart';

class CompleteSwimCourseBookingInput {
  final String loginEmail;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final List<ChildInfo> childInfos;
  final List<CustomerInvitedInfo> customerInvitedInfos;
  final DateTime birthDate;
  final int swimCourseID;
  final List<int> swimPoolIDs;
  final String referenceBooking;
  final int bookingDateTypID;
  final int? fixDateID;
  final List<DateTime> desiredDateTimes;

  CompleteSwimCourseBookingInput({
    required this.loginEmail,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.childInfos,
    required this.customerInvitedInfos,
    required this.birthDate,
    required this.swimCourseID,
    required this.swimPoolIDs,
    required this.referenceBooking,
    required this.bookingDateTypID,
    required this.fixDateID,
    required this.desiredDateTimes,
  });

  Map<String, dynamic> toGraphqlJson() {
    return {
      'loginEmail': loginEmail,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'students': childInfos.map((childInfo) => childInfo.toJson()).toList(),
      'customersInvited': customerInvitedInfos
          .map((customerInvitedInfo) => customerInvitedInfo.toJson())
          .toList(),
      'birthDate': birthDate.toIso8601String(),
      'swimCourseID': swimCourseID,
      'swimPoolIDs': swimPoolIDs,
      'referenceBooking': referenceBooking,
      'bookingDateTypID': bookingDateTypID,
      'fixDateID': fixDateID,
      'desiredDateTimes':
          desiredDateTimes.map((dt) => dt.toIso8601String()).toList(),
    };
  }
}

class NewStudentAndBookingInput {
  final String loginEmail;
  final String studentFirstName;
  final String studentLastName;
  final DateTime birthDate;
  final int swimCourseID;
  final List<int> swimPoolIDs;
  final String referenceBooking;
  final int? fixDateID;

  NewStudentAndBookingInput({
    required this.loginEmail,
    required this.studentFirstName,
    required this.studentLastName,
    required this.birthDate,
    required this.swimCourseID,
    required this.swimPoolIDs,
    required this.referenceBooking,
    required this.fixDateID,
  });

  Map<String, dynamic> toGraphqlJson() {
    return {
      'loginEmail': loginEmail,
      'studentFirstName': studentFirstName,
      'studentLastName': studentLastName,
      'birthDate': birthDate.toIso8601String(),
      'swimCourseID': swimCourseID,
      'swimPoolIDs': swimPoolIDs,
      'referenceBooking': referenceBooking,
      'fixDateID': fixDateID,
    };
  }
}
