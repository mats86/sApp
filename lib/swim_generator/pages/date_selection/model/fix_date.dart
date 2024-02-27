class FixDate {
  final int fixDateID;
  final int swimPoolID;
  final int swimCourseID;
  final DateTime? fixDateFrom;
  final DateTime? fixDateTo;
  final bool isFixDateActive;

  FixDate({
    required this.fixDateID,
    required this.swimPoolID,
    required this.swimCourseID,
    required this.fixDateFrom,
    required this.fixDateTo,
    required this.isFixDateActive,
  });

  factory FixDate.fromJson(Map<String, dynamic> json) {
    return FixDate(
      fixDateID: json['fixDateID'] ?? 0,
      swimPoolID: json['swimPoolID'] ?? 0,
      swimCourseID: json['swimCourseID'] ?? 0,
      fixDateFrom: DateTime.tryParse(json['fixDateFrom']) ?? DateTime(1970),
      fixDateTo: DateTime.tryParse(json['fixDateTo']) ?? DateTime(1970),
      isFixDateActive: json['isFixDateActive'] ?? false,
    );
  }

  const FixDate.empty()
      : fixDateID = 0,
        swimPoolID = 0,
        swimCourseID = 0,
        fixDateFrom = null,
        fixDateTo = null,
        isFixDateActive = false;

  bool get isEmpty {
    return fixDateID == 0 &&
        swimPoolID == 0 &&
        swimCourseID == 0 &&
        fixDateFrom == null &&
        fixDateTo == null &&
        isFixDateActive == false;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}

class FixDateDetail {
  final int fixDateID;
  final int swimPoolID;
  final String swimPoolName;
  final int swimCourseID;
  final String swimCourseName;
  final DateTime? fixDateFrom;
  final DateTime? fixDateTo;
  final bool isFixDateActive;

  FixDateDetail({
    required this.fixDateID,
    required this.swimPoolID,
    required this.swimPoolName,
    required this.swimCourseID,
    required this.swimCourseName,
    required this.fixDateFrom,
    required this.fixDateTo,
    required this.isFixDateActive,
  });

  factory FixDateDetail.fromJson(Map<String, dynamic> json) {
    return FixDateDetail(
      fixDateID: json['fixDateID'] ?? 0,
      swimPoolID: json['swimPoolID'] ?? 0,
      swimPoolName: json['swimPoolName'] ?? '',
      swimCourseID: json['swimCourseID'] ?? 0,
        swimCourseName: json['swimCourseName'] ?? '',
      fixDateFrom: DateTime.tryParse(json['fixDateFrom']) ?? DateTime(1970),
      fixDateTo: DateTime.tryParse(json['fixDateTo']) ?? DateTime(1970),
      isFixDateActive: json['isFixDateActive'] ?? false,
    );
  }

  const FixDateDetail.empty()
      : fixDateID = 0,
        swimPoolID = 0,
        swimPoolName = '',
        swimCourseID = 0,
        swimCourseName = '',
        fixDateFrom = null,
        fixDateTo = null,
        isFixDateActive = false;

  bool get isEmpty {
    return fixDateID == 0 &&
        swimPoolID == 0 &&
        swimCourseID == 0 &&
        fixDateFrom == null &&
        fixDateTo == null &&
        isFixDateActive == false;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
