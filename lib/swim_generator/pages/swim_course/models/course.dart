//
// class Course {
//   final int id;
//   final int swimLevelId;
//   final String swimCourseName;
//   final double swimCourseMinAge;
//   final double swimCourseMaxAge;
//   final String swimCoursePrice;
//   final String swimCourseDescription;
//   final bool swimCourseHasFixedDates;
//   final String swimCourseDuration;
//   final bool isCourseVisible;
//
//   const Course({
//     required this.id,
//     required this.swimLevelId,
//     required this.swimCourseName,
//     required this.swimCourseMinAge,
//     required this.swimCourseMaxAge,
//     required this.swimCoursePrice,
//     required this.swimCourseDescription,
//     required this.swimCourseHasFixedDates,
//     required this.swimCourseDuration,
//     required this.isCourseVisible});
//
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//         id: json['courseID'],
//         swimLevelId: json['swim_level_id'],
//         swimCourseName: json['courseName'],
//         swimCourseMinAge: json['courseMinimumAge'].toDouble(),
//         swimCourseMaxAge: json['courseMaximumAge'].toDouble(),
//         swimCoursePrice: json['coursePrice'],
//         swimCourseDescription: json['courseDescription'],
//         swimCourseHasFixedDates: json['courseHasFixedDates'],
//         swimCourseDuration: json['courseDuration'],
//         isCourseVisible: json['isCourseVisible']);
//   }
//
//   const Course.empty()
//       : id = 0,
//         swimLevelId = 0,
//         swimCourseName = '',
//         swimCourseMinAge = 0,
//         swimCourseMaxAge = 0,
//         swimCoursePrice = '',
//         swimCourseDescription = '',
//         swimCourseHasFixedDates = false,
//         swimCourseDuration = '',
//         isCourseVisible = false;
// }
