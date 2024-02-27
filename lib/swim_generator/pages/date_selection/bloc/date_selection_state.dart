part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {
  final List<FixDate> fixDates;
  final FixDateModel fixDateModel;
  final FixDate selectedFixDate;
  final FormzSubmissionStatus loadingFixDates;
  final bool hasFixedDesiredDate;
  final int bookingDateTypID;
  final bool flexFixDate;
  final DateTime? dateTime1;
  final DateTime? dateTime2;
  final DateTime? dateTime3;
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
    this.dateTime1,
    this.dateTime2,
    this.dateTime3,
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
    DateTime? dateTime1,
    DateTime? dateTime2,
    DateTime? dateTime3,
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
      dateTime1: dateTime1 ?? this.dateTime1,
      dateTime2: dateTime2 ?? this.dateTime2,
      dateTime3: dateTime3 ?? this.dateTime3,
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
    dateTime1,
    dateTime2,
    dateTime3,
    submissionStatus
  ];
}
