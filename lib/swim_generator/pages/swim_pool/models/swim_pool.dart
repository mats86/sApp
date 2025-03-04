class SwimPool {
  final int index;
  final int swimPoolID;
  final int brevoListId;
  final String swimPoolName;
  final String swimPoolAddress;
  final String swimPoolPhoneNumber;
  final List<OpenTime> swimPoolOpeningTimes;
  final bool swimPoolHasFixedDate;
  final bool isSwimPoolVisible;
  final bool isSelected;

  SwimPool({
    this.index = 0,
    required this.swimPoolID,
    required this.brevoListId,
    required this.swimPoolName,
    required this.swimPoolAddress,
    required this.swimPoolPhoneNumber,
    required this.swimPoolOpeningTimes,
    required this.swimPoolHasFixedDate,
    required this.isSwimPoolVisible,
    required this.isSelected,
  });

  const SwimPool.empty()
      : index = 0,
        swimPoolID = 0,
        brevoListId = 0,
        swimPoolName = '',
        swimPoolAddress = '',
        swimPoolPhoneNumber = '',
        swimPoolOpeningTimes = const [],
        swimPoolHasFixedDate = false,
        isSwimPoolVisible = false,
        isSelected = false;

  factory SwimPool.fromJson(Map<String, dynamic> json) {
    var openingTimesJson = json['swimPoolOpeningTimes'] as List<dynamic>? ?? [];

    return SwimPool(
      swimPoolID: json['swimPoolID'],
      brevoListId: json['brevoListId'],
      swimPoolName: json['swimPoolName'],
      swimPoolAddress: json['swimPoolAddress'],
      swimPoolPhoneNumber: json['swimPoolPhoneNumber'],
      swimPoolOpeningTimes:
      openingTimesJson.map((i) => OpenTime.fromJson(i)).toList(),
      swimPoolHasFixedDate: json['swimPoolHasFixedDate'],
      isSwimPoolVisible: json['isSwimPoolVisible'],
      isSelected: false,
    );
  }
  Map<String, dynamic> toJson() => {
    'swimPoolID': swimPoolID,
    'swimPoolName': swimPoolName,
    'swimPoolAddress': swimPoolAddress,
  };
}

class SwimPoolByCode {
  final int swimPoolID;
  final int brevoListId;
  final String swimPoolName;

  SwimPoolByCode({
    required this.swimPoolID,
    required this.brevoListId,
    required this.swimPoolName,
  });

  const SwimPoolByCode.empty()
      :
        swimPoolID = 0,
        brevoListId = 0,
        swimPoolName = '';

  factory SwimPoolByCode.fromJson(Map<String, dynamic> json) {

    return SwimPoolByCode(
      swimPoolID: json['swimPoolID'],
      brevoListId: json['brevoListId'],
      swimPoolName: json['swimPoolName'],
    );
  }
  Map<String, dynamic> toJson() => {
    'swimPoolID': swimPoolID,
    'swimPoolName': swimPoolName,
    'brevoListId': brevoListId,
  };
}

class OpenTime {
  final String day;
  final String openTime;
  final String closeTime;

  OpenTime({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  factory OpenTime.fromJson(Map<String, dynamic> json) {
    return OpenTime(
      day: json['day'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }
}