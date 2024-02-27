class SwimCourse {
  final int swimCourseID;
  final String swimCourseName;
  final double swimCourseMinAge;
  final double swimCourseMaxAge;
  final double swimCoursePrice;
  final String swimCourseDescription;
  final int swimCourseDateTypID;
  final String swimCourseDuration;
  final bool isSwimCourseVisible;
  final int swimLevelID;
  final DateTime? swimCourseStartBooking;
  final DateTime? swimCourseEndBooking;
  final DateTime? swimCourseStartVisible;
  final DateTime? swimCourseEndVisible;
  final String? swimCourseUrl;
  final bool isAdultCourse;
  final bool isGroupCourse;

  SwimCourse({
    required this.swimCourseID,
    required this.swimCourseName,
    required this.swimCourseMinAge,
    required this.swimCourseMaxAge,
    required this.swimCoursePrice,
    required this.swimCourseDescription,
    required this.swimCourseDateTypID,
    required this.swimCourseDuration,
    required this.isSwimCourseVisible,
    required this.swimLevelID,
    required this.swimCourseStartBooking,
    required this.swimCourseEndBooking,
    required this.swimCourseStartVisible,
    required this.swimCourseEndVisible,
    required this.swimCourseUrl,
    required this.isAdultCourse,
    required this.isGroupCourse,
  });

  factory SwimCourse.fromJson(Map<String, dynamic> json) {
    return SwimCourse(
      swimCourseID: json['swimCourseID'],
      swimCourseName: json['swimCourseName'],
      swimCourseMinAge: json['swimCourseMinAge'],
      swimCourseMaxAge: json['swimCourseMaxAge'],
      swimCoursePrice: json['swimCoursePrice'].toDouble(),
      swimCourseDescription: json['swimCourseDescription'],
      swimCourseDateTypID: json['swimCourseDateTypID'],
      swimCourseDuration: json['swimCourseDuration'],
      isSwimCourseVisible: json['isSwimCourseVisible'],
      swimLevelID: json['swimLevelID'],
      swimCourseStartBooking: json['swimCourseStartBooking'] != null
          ? DateTime.parse(json['swimCourseStartBooking'])
          : null,
      swimCourseEndBooking: json['swimCourseEndBooking'] != null
          ? DateTime.parse(json['swimCourseEndBooking'])
          : null,
      swimCourseStartVisible: json['swimCourseStartVisible'] != null
          ? DateTime.parse(json['swimCourseStartVisible'])
          : null,
      swimCourseEndVisible: json['swimCourseEndVisible'] != null
          ? DateTime.parse(json['swimCourseEndVisible'])
          : null,
      swimCourseUrl: json['swimCourseUrl'],
      isAdultCourse: json['isAdultCourse'],
      isGroupCourse: json['isGroupCourse'],
    );
  }

  const SwimCourse.empty()
      : swimCourseID = 0,
        swimCourseName = '',
        swimCourseMinAge = 0,
        swimCourseMaxAge = 0,
        swimCoursePrice = 0,
        swimCourseDescription = '',
        swimCourseDateTypID = 0,
        swimCourseDuration = '',
        isSwimCourseVisible = false,
        swimLevelID = 0,
        swimCourseStartBooking = null,
        swimCourseEndBooking = null,
        swimCourseStartVisible = null,
        swimCourseEndVisible = null,
        swimCourseUrl = "",
        isAdultCourse = false,
        isGroupCourse = false;

  bool get isEmpty {
    return swimCourseID == 0 &&
        swimCourseName.isEmpty &&
        swimCourseMinAge == 0 &&
        swimCourseMaxAge == 0 &&
        swimCoursePrice == 0 &&
        swimCourseDescription.isEmpty &&
        swimCourseDateTypID == 0 &&
        swimCourseDuration.isEmpty &&
        isSwimCourseVisible == false &&
        swimLevelID == 0 &&
        swimCourseStartBooking == null &&
        swimCourseEndBooking == null &&
        swimCourseStartVisible == null &&
        swimCourseEndVisible == null &&
        swimCourseUrl == "" &&
        isAdultCourse == false &&
        isGroupCourse == false;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
