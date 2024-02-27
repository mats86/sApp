import 'package:equatable/equatable.dart';

import '../pages/swim_season/models/swim_season.dart';

class SwimSeasonInfo extends Equatable {
  final SwimSeason? swimSeason;

  const SwimSeasonInfo({
    this.swimSeason,
  });

  const SwimSeasonInfo.empty() : swimSeason = const SwimSeason.empty();

  SwimSeasonInfo copyWith({SwimSeason? swimSeason}) {
    return SwimSeasonInfo(swimSeason: swimSeason ?? this.swimSeason);
  }

  bool get isEmpty {
    return swimSeason?.isEmpty ?? true;
  }

  @override
  List<Object?> get props => [swimSeason];
}
