class SwimSchool {
  final int swimSchoolID;
  final String swimSchoolName;
  final String swimSchoolUrl;

  SwimSchool({
    required this.swimSchoolID,
    required this.swimSchoolName,
    required this.swimSchoolUrl,
  });

  factory SwimSchool.fromJson(Map<String, dynamic> json) {
    return SwimSchool(
      swimSchoolID: json['swimSchoolID'],
      swimSchoolName: json['swimSchoolName'],
      swimSchoolUrl: json['swimSchoolUrl'],
    );
  }

  const SwimSchool.empty()
      : swimSchoolID = 0,
        swimSchoolName = '',
        swimSchoolUrl = '';

  bool get isEmpty {
    return swimSchoolID == 0 && swimSchoolName.isEmpty && swimSchoolUrl.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
