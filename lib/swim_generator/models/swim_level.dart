import 'package:equatable/equatable.dart';

class SwimLevel extends Equatable {
  final SwimLevelEnum? swimLevel;

  const SwimLevel({
    this.swimLevel,
  });

  const SwimLevel.empty() : swimLevel = SwimLevelEnum.UNDEFINED;

  SwimLevel copyWith({SwimLevelEnum? swimLevel}) {
    return SwimLevel(
      swimLevel: swimLevel ?? this.swimLevel,
    );
  }

  bool get isEmpty {
    return swimLevel == SwimLevelEnum.UNDEFINED;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object?> get props => [swimLevel];
}

enum SwimLevelEnum {
  EINSTEIGERKURS,
  AUFSTEIGERKURS,
  UNDEFINED,
}

SwimLevelEnum valueOf(int index) {
  return SwimLevelEnum.values[index];
}
