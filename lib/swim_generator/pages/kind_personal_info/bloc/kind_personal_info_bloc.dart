import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../../birth_day/models/birth_day_model.dart';
import '../../parent_personal_info/models/email_model.dart';
import '../../parent_personal_info/models/phone_number_model.dart';
import '../../result/models/checkbox_model.dart';
import '../../swim_course/models/swim_course.dart';
import '../models/models.dart';
import '../models/swim_course_booking_by_code.dart';

part 'kind_personal_info_event.dart';

part 'kind_personal_info_repository.dart';

part 'kind_personal_info_state.dart';

class KindPersonalInfoBloc
    extends Bloc<KindPersonalInfoEvent, KindPersonalInfoState> {
  final KindPersonalRepository service;

  KindPersonalInfoBloc(this.service) : super(const KindPersonalInfoState()) {
    on<UpdateChildInfo>(_onUpdateChildInfo);
    on<BirthDayChanged>(_onBirthDayChanged);
    on<SelectChild>(_onSelectChild);
    on<SelectFriend>(_onSelectFriend);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<PhysicalDelayChanged>(_onPhysicalDelayChanged);
    on<MentalDelayChanged>(_onMentalDelayChanged);
    on<NoLimitsChanged>(_onNoLimitsChanged);
    on<CustomerInvitedFirstNameChanged>(_onGuardianFirstNameChanged);
    on<CustomerInvitedLastNameChanged>(_onGuardianLastNameChanged);
    on<CustomerInvitedEmailChanged>(_onGuardianEmailChanged);
    on<CustomerInvitedPhoneNumberChanged>(_onGuardianPhoneNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<LoadSwimBookingByCode>(_onLoadSwimBookingByCode);
    on<CloseAlertDialog>(_onCloseAlertDialog);
  }

  void _onUpdateChildInfo(
    UpdateChildInfo event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    emit(state.copyWith(childInfo: event.childInfo));
  }

  void _onBirthDayChanged(
    BirthDayChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    bool isCheckboxSelected = state.childInfo.isPhysicalDelay.value ||
        state.childInfo.isMentalDelay.value ||
        state.childInfo.isNoLimit.value;
    final birthDay = BirthDayModel.dirty(event.birthDay);
    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(birthDay: birthDay),
        isValid: Formz.validate([
              state.childInfo.firstName,
              state.childInfo.lastName,
              birthDay
            ]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onSelectChild(
    SelectChild event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    emit(state.copyWith(childFriendSelected: false, isValid: false));
  }

  void _onSelectFriend(
    SelectFriend event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    emit(state.copyWith(childFriendSelected: true, isValid: false));
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    bool isCheckboxSelected = state.childInfo.isPhysicalDelay.value ||
        state.childInfo.isMentalDelay.value ||
        state.childInfo.isNoLimit.value;
    final updatedFirstName = FirstNameModel.dirty(event.firstName);
    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(firstName: updatedFirstName),
        isValid: Formz.validate(
              [
                updatedFirstName,
                state.childInfo.lastName,
                state.childInfo.birthDay,
              ],
            ) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    bool isCheckboxSelected = state.childInfo.isPhysicalDelay.value ||
        state.childInfo.isMentalDelay.value ||
        state.childInfo.isNoLimit.value;

    final updatedLastName = LastNameModel.dirty(event.lastName);

    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(lastName: updatedLastName),
        isValid: Formz.validate([
              state.childInfo.firstName,
              updatedLastName,
              state.childInfo.birthDay
            ]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onPhysicalDelayChanged(
    PhysicalDelayChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final isPhysicalDelay = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected = event.isChecked ||
        state.childInfo.isMentalDelay.value ||
        state.childInfo.isNoLimit.value;
    List<String> updatedOptions =
        List.from(state.childInfo.kidsDevelopState.split(', '));
    if (event.isChecked) {
      updatedOptions.add('Körperliche Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Körperliche Entwicklungsverzögerungen');
    }
    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(
          kidsDevelopState: updatedOptions.map((e) => e.toString()).join(', '),
          isPhysicalDelay: isPhysicalDelay,
          isNoLimit: const CheckboxModel.pure(),
        ),
        isValid: Formz.validate(
                [state.childInfo.firstName, state.childInfo.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onMentalDelayChanged(
    MentalDelayChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final isMentalDelay = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected = state.childInfo.isPhysicalDelay.value ||
        event.isChecked ||
        state.childInfo.isNoLimit.value;
    List<String> updatedOptions =
        List.from(state.childInfo.kidsDevelopState.split(', '));
    if (event.isChecked) {
      updatedOptions.add('GEISTIGE Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('GEISTIGE Entwicklungsverzögerungen');
    }
    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(
          kidsDevelopState: updatedOptions.map((e) => e.toString()).join(', '),
          isMentalDelay: isMentalDelay,
          isNoLimit: const CheckboxModel.pure(),
        ),
        isValid: Formz.validate(
                [state.childInfo.firstName, state.childInfo.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onNoLimitsChanged(
    NoLimitsChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final isNoLimit = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected = state.childInfo.isPhysicalDelay.value ||
        state.childInfo.isMentalDelay.value ||
        event.isChecked;
    List<String> updatedOptions =
        List.from(state.childInfo.kidsDevelopState.split(', '));
    if (event.isChecked) {
      updatedOptions.clear();
      updatedOptions.add('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Keine Einschränkungen');
    }
    emit(
      state.copyWith(
        childInfo: state.childInfo.copyWith(
          kidsDevelopState: updatedOptions.map((e) => e.toString()).join(', '),
          isPhysicalDelay: const CheckboxModel.pure(),
          isMentalDelay: const CheckboxModel.pure(),
          isNoLimit: isNoLimit,
        ),
        isValid: Formz.validate(
                [state.childInfo.firstName, state.childInfo.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onGuardianFirstNameChanged(
    CustomerInvitedFirstNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final updatedFirstName = FirstNameModel.dirty(event.firstName);
    emit(
      state.copyWith(
        customerInvitedInfo: state.customerInvitedInfo
            .copyWith(customerInvitedFirstName: updatedFirstName),
        isValid: Formz.validate(
          [
            updatedFirstName,
            state.customerInvitedInfo.customerInvitedLastName,
            state.customerInvitedInfo.customerInvitedEmail,
            state.customerInvitedInfo.customerInvitedPhoneNumber,
          ],
        ),
      ),
    );
  }

  void _onGuardianLastNameChanged(
    CustomerInvitedLastNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final updatedLastName = LastNameModel.dirty(event.lastName);

    emit(
      state.copyWith(
        customerInvitedInfo: state.customerInvitedInfo
            .copyWith(customerInvitedLastName: updatedLastName),
        isValid: Formz.validate(
          [
            state.customerInvitedInfo.customerInvitedFirstName,
            updatedLastName,
            state.customerInvitedInfo.customerInvitedEmail,
            state.customerInvitedInfo.customerInvitedPhoneNumber,
          ],
        ),
      ),
    );
  }

  void _onGuardianEmailChanged(
    CustomerInvitedEmailChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final updatedEmail = EmailModel.dirty(event.email);

    emit(
      state.copyWith(
        customerInvitedInfo: state.customerInvitedInfo
            .copyWith(customerInvitedEmail: updatedEmail),
        isValid: Formz.validate(
          [
            state.customerInvitedInfo.customerInvitedFirstName,
            state.customerInvitedInfo.customerInvitedLastName,
            updatedEmail,
            state.customerInvitedInfo.customerInvitedPhoneNumber,
          ],
        ),
      ),
    );
  }

  void _onGuardianPhoneNumberChanged(
    CustomerInvitedPhoneNumberChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final updatedPhoneNumber = PhoneNumberModel.dirty(event.phoneNumber);

    emit(
      state.copyWith(
        customerInvitedInfo: state.customerInvitedInfo
            .copyWith(customerInvitedPhoneNumber: updatedPhoneNumber),
        isValid: Formz.validate(
          [
            state.customerInvitedInfo.customerInvitedFirstName,
            state.customerInvitedInfo.customerInvitedLastName,
            state.customerInvitedInfo.customerInvitedEmail,
            updatedPhoneNumber
          ],
        ),
      ),
    );
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (!state.childFriendSelected) {
        double age =
            calculateAge(state.childInfo.birthDay.value!, getSpecificDate());
        if ((age >= event.selectedCourse.swimCourseMinAge) &&
            (age <= event.selectedCourse.swimCourseMaxAge)) {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
        }
      } else {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      }
    }
  }

  void _onLoadSwimBookingByCode(
    LoadSwimBookingByCode event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: FormzSubmissionStatus.inProgress));
    try {
      var swimCourseBookingByCode =
          await service.loadSwimCourseBookingByCode(event.swimBookingCode);
      emit(state.copyWith(
          isCodeLink: true,
          swimCourseBookingByCode: swimCourseBookingByCode,
          loadingStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingStatus: FormzSubmissionStatus.failure));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onCloseAlertDialog(
    CloseAlertDialog event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.initial,));
  }
}

double calculateAge(DateTime birthDate, DateTime specificDate) {
  int yearDifference = specificDate.year - birthDate.year;
  int monthDifference = specificDate.month - birthDate.month;
  int dayDifference = specificDate.day - birthDate.day;

  if (monthDifference < 0 || (monthDifference == 0 && dayDifference < 0)) {
    yearDifference--;
    monthDifference += 12;
  }

  if (dayDifference < 0) {
    monthDifference--;
  }

  double age = yearDifference + (monthDifference / 12.0);
  return age;
}

DateTime getSpecificDate() {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  return DateTime(currentYear, 6, 1);
}
