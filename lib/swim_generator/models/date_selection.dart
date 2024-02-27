import 'package:equatable/equatable.dart';
import 'package:swim_generator_app/swim_generator/pages/date_selection/model/fix_date.dart';

class DateSelection extends Equatable {
  final FixDate fixDate;
  final bool flexFixDate;
  final int bookingDateTypID;
  final List<DateTime> dateTimes;

  const DateSelection({
    required this.fixDate,
    required this.flexFixDate,
    required this.bookingDateTypID,
    required this.dateTimes,
  });

  const DateSelection.empty()
      : this(
    fixDate: const FixDate.empty(),
    flexFixDate: false,
    bookingDateTypID: 0,
    dateTimes: const [],
  );

  DateSelection copyWith({
    FixDate? fixDate,
    bool? flexFixDate,
    int? bookingDateTypID,
    List<DateTime>? dateTimes,
  }) {
    return DateSelection(
      fixDate: fixDate ?? this.fixDate,
      flexFixDate: flexFixDate ?? this.flexFixDate,
      bookingDateTypID: bookingDateTypID ?? this.bookingDateTypID,
      dateTimes: dateTimes ?? this.dateTimes,
    );
  }

  bool get isEmpty {
    return fixDate.isEmpty && dateTimes.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object?> get props =>
      [
        fixDate,
        flexFixDate,
        bookingDateTypID,
        dateTimes,
      ];
}
