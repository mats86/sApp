import '../../swim_course/models/swim_course.dart';
import '../../swim_pool/models/swim_pool.dart';

class SwimCourseBookingByCode {
  final int swimCourseBookingID;
  final SwimCourse swimCourse;
  final int? fixDateID;
  final int bookingDateTypID;
  final String referenceBooking;
  final List<SwimPool>
      swimPools; // Hinzugefügte Zeile für die Schwimmbadliste

  SwimCourseBookingByCode({
    required this.swimCourseBookingID,
    required this.swimCourse,
    this.fixDateID,
    required this.bookingDateTypID,
    required this.referenceBooking,
    required this.swimPools,
  });

  const SwimCourseBookingByCode.empty()
      : swimCourseBookingID = 0,
        swimCourse = const SwimCourse.empty(),
        fixDateID = null,
        bookingDateTypID = 0,
        referenceBooking = '',
        swimPools = const [];

  factory SwimCourseBookingByCode.fromJson(Map<String, dynamic> json) =>
      SwimCourseBookingByCode(
        swimCourseBookingID: json['swimCourseBookingID'],
        swimCourse: SwimCourse.fromJson(json['swimCourse'] as Map<String, dynamic>),
        fixDateID: json['fixDateID'] != null
            ? int.tryParse(json['fixDateID'].toString())
            : null,
        bookingDateTypID: json['bookingDateTypID'],
        referenceBooking: json['referenceBooking'],
        swimPools: (json['swimPools'] as List)
            .map((item) => SwimPool.fromJson(item))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'swimCourseBookingID': swimCourseBookingID,
        'swimCourse': swimCourse,
        'fixDateID': fixDateID,
        'bookingDateTypID': bookingDateTypID,
        'referenceBooking': referenceBooking,
        'swimPools': swimPools.map((pool) => pool.toJson()).toList(),
      };
}
