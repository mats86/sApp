class SwimCourseBookingResult {
  final bool isSuccess;
  final SwimCourseBookingData? swimCourseBookingData;
  final String? errorMessage;

  SwimCourseBookingResult(
      {required this.isSuccess, this.swimCourseBookingData, this.errorMessage});
}

class SwimCourseBookingData {
  final int swimCourseBookingID;
  final int swimCourseID;
  final String bookingDate;
  final int paymentStatus;
  final String referenceBooking;
  final int bookingDateTypID;
  final bool isWaitList;
  final String inviteCode;

  SwimCourseBookingData({
    required this.swimCourseBookingID,
    required this.swimCourseID,
    required this.bookingDate,
    required this.paymentStatus,
    required this.referenceBooking,
    required this.bookingDateTypID,
    required this.isWaitList,
    required this.inviteCode,
  });

  factory SwimCourseBookingData.fromJson(Map<String, dynamic> json) {
    return SwimCourseBookingData(
      swimCourseBookingID: json['swimCourseBookingID'],
      swimCourseID: json['swimCourseID'],
      bookingDate: json['bookingDate'],
      paymentStatus: json['paymentStatus'],
      referenceBooking: json['referenceBooking'],
      bookingDateTypID: json['bookingDateTypID'],
      isWaitList: json['isWaitList'],
      inviteCode: json['inviteCode'],
    );
  }
}
