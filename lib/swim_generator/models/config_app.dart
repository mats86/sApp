import 'package:equatable/equatable.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';

class ConfigApp extends Equatable {
  final bool isEmailExists;
  final bool isDirectLinks;
  final bool isBooking;
  final bool isStartFixDate;
  final String referenceBooking;
  final SchoolInfo schoolInfo;

  const ConfigApp({
    required this.isEmailExists,
    required this.isDirectLinks,
    required this.isBooking,
    required this.isStartFixDate,
    required this.referenceBooking,
    required this.schoolInfo,
  });

  const ConfigApp.empty()
      : this(
    isEmailExists: false,
    isDirectLinks: false,
    isBooking: false,
    isStartFixDate: false,
    referenceBooking: '',
    schoolInfo: const SchoolInfo(),
  );

  ConfigApp copyWith({
    bool? isEmailExists,
    bool? isDirectLinks,
    bool? isBooking,
    bool? isStartFixDate,
    String? referenceBooking,
    SchoolInfo? schoolInfo,
  }) {
    return ConfigApp(
      isEmailExists: isEmailExists ?? this.isEmailExists,
      isDirectLinks: isDirectLinks ?? this.isDirectLinks,
      isBooking: isBooking ?? this.isBooking,
      isStartFixDate: isStartFixDate ?? this.isStartFixDate,
      referenceBooking: referenceBooking ?? this.referenceBooking,
      schoolInfo: schoolInfo ?? this.schoolInfo,
    );
  }

  @override
  List<Object> get props => [
    isEmailExists,
    isDirectLinks,
    isBooking,
    isStartFixDate,
    referenceBooking,
    schoolInfo,
  ];
}
