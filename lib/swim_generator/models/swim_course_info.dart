import 'package:equatable/equatable.dart';

import '../pages/swim_course/models/swim_course.dart';

class SwimCourseInfo extends Equatable {
  const SwimCourseInfo({
    required this.season,
    required this.swimCourse,
  });

  final String season;
  final SwimCourse swimCourse;

  const SwimCourseInfo.empty()
      : this(season: '', swimCourse: const SwimCourse.empty());

  SwimCourseInfo copyWith({
    String? season,
    SwimCourse? swimCourse,
  }) {
    return SwimCourseInfo(
      season: season ?? this.season,
      swimCourse: swimCourse ?? this.swimCourse,
    );
  }

  bool get isEmpty {
    return swimCourse.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object?> get props => [season, swimCourse];
}
