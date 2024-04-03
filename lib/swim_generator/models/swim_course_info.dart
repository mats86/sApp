import 'package:equatable/equatable.dart';

import '../pages/swim_course/models/swim_course.dart';

class SwimCourseInfo extends Equatable {
  const SwimCourseInfo({
    required this.swimCourse,
    required this.isForMultiChild,
    required this.childLength,
  });

  final SwimCourse swimCourse;
  final bool isForMultiChild;
  final int childLength;

  const SwimCourseInfo.empty()
      : this(
            swimCourse: const SwimCourse.empty(),
            isForMultiChild: false,
            childLength: 1);

  SwimCourseInfo copyWith({
    SwimCourse? swimCourse,
    bool? isForMultiChild,
    int? childLength,
  }) {
    return SwimCourseInfo(
      swimCourse: swimCourse ?? this.swimCourse,
      isForMultiChild: isForMultiChild ?? this.isForMultiChild,
      childLength: childLength ?? this.childLength,
    );
  }

  bool get isEmpty {
    return swimCourse.isEmpty && isForMultiChild == false;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object?> get props => [swimCourse, isForMultiChild];
}
