class UtilTime {
  DateTime updateYear(DateTime originalDateTime, int newYear) {
    return DateTime(
      newYear,
      originalDateTime.month,
      originalDateTime.day,
      originalDateTime.hour,
      originalDateTime.minute,
      originalDateTime.second,
      originalDateTime.millisecond,
      originalDateTime.microsecond,
    );
  }
}
