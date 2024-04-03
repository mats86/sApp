part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {
  final List<FixDate> fixDates;
  final FixDateModel fixDateModel;
  final FixDate selectedFixDate;
  final FormzSubmissionStatus loadingFixDates;
  final bool hasFixedDesiredDate;
  final int bookingDateTypID;
  final bool flexFixDate;
  final List<DateTime>? selectedDates;
  final List<TimeOfDay>? selectedTimes;
  final int selectedDateTimeLength;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const DateSelectionState({
    this.fixDates = const [],
    this.fixDateModel = const FixDateModel.pure(),
    this.selectedFixDate = const FixDate.empty(),
    this.loadingFixDates = FormzSubmissionStatus.initial,
    this.hasFixedDesiredDate = false,
    this.bookingDateTypID = 0,
    this.flexFixDate = false,
    this.selectedDates = const [],
    this.selectedTimes = const [],
    this.selectedDateTimeLength = 0,
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  DateSelectionState copyWith({
    List<FixDate>? fixDates,
    FixDateModel? fixDateModel,
    FixDate? selectedFixDate,
    FormzSubmissionStatus? loadingFixDates,
    bool? hasFixedDesiredDate,
    int? bookingDateTypID,
    bool? flexFixDate,
    List<DateTime>? selectedDates,
    List<TimeOfDay>? selectedTimes,
    int? selectedDateTimeLength,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return DateSelectionState(
      fixDates: fixDates ?? this.fixDates,
      fixDateModel: fixDateModel ?? this.fixDateModel,
      selectedFixDate: selectedFixDate ?? this.selectedFixDate,
      loadingFixDates: loadingFixDates ?? this.loadingFixDates,
      hasFixedDesiredDate: hasFixedDesiredDate ?? this.hasFixedDesiredDate,
      bookingDateTypID: bookingDateTypID ?? this.bookingDateTypID,
      flexFixDate: flexFixDate ?? this.flexFixDate,
      selectedDates: selectedDates ?? this.selectedDates,
      selectedTimes: selectedTimes ?? this.selectedTimes,
      selectedDateTimeLength:
          selectedDateTimeLength ?? this.selectedDateTimeLength,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        fixDates,
        fixDateModel,
        loadingFixDates,
        hasFixedDesiredDate,
        bookingDateTypID,
        flexFixDate,
        selectedDates,
        selectedTimes,
        selectedDateTimeLength,
        submissionStatus
      ];
}
