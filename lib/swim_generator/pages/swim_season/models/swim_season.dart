class SwimSeason {
  SwimSeason({
    required this.name,
    required this.refDate,
    required this.swimSeasonEnum,
  });

  final String name;
  final DateTime? refDate;
  final SwimSeasonEnum swimSeasonEnum;

  factory SwimSeason.fromJson(Map<String, dynamic> json) {
    return SwimSeason(
      name: json['name'],
      refDate: json['refDate'],
      swimSeasonEnum: json['swimSeasonEnum'],
    );
  }

  const SwimSeason.empty()
      : name = '',
        refDate = null,
        swimSeasonEnum = SwimSeasonEnum.UNDEFINED;

  bool get isEmpty {
    return name.isEmpty && swimSeasonEnum == SwimSeasonEnum.UNDEFINED;
  }
}

enum SwimSeasonEnum { RESERVIEREN, BUCHEN, UNDEFINED }
