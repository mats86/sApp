import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../result/models/checkbox_model.dart';
import '../models/models.dart';

part 'kind_personal_info_event.dart';

part 'kind_personal_info_state.dart';

class KindPersonalInfoBloc
    extends Bloc<KindPersonalInfoEvent, KindPersonalInfoState> {
  KindPersonalInfoBloc() : super(const KindPersonalInfoState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<PhysicalDelayChanged>(_onPhysicalDelayChanged);
    on<MentalDelayChanged>(_onMentalDelayChanged);
    on<NoLimitsChanged>(_onNoLimitsChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFirstNameChanged(
      FirstNameChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final firstName = FirstNameModel.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([firstName, state.lastName]),
      ),
    );
  }

  void _onFirstNameUnfocused(
      FirstNameUnfocused event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final firstName = FirstNameModel.dirty(state.firstName.value);
    emit(state.copyWith(
      firstName: firstName,
      isValid: Formz.validate([firstName, state.lastName]),
    ));
  }

  void _onLastNameChanged(
      LastNameChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final lastName = LastNameModel.dirty(event.lastName);
    bool isCheckboxSelected = state.isPhysicalDelay.value ||
        state.isMentalDelay.value ||
        state.isNoLimit.value;
    emit(
      state.copyWith(
        lastName: lastName,
        isValid:
        Formz.validate([state.firstName, lastName]) && isCheckboxSelected,
      ),
    );
  }

  void _onLastNameUnfocused(
      LastNameUnfocused event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final lastName = LastNameModel.dirty(state.lastName.value);
    bool isCheckboxSelected = state.isPhysicalDelay.value ||
        state.isMentalDelay.value ||
        state.isNoLimit.value;
    emit(state.copyWith(
      lastName: lastName,
      isValid:
      Formz.validate([state.firstName, lastName]) && isCheckboxSelected,
    ));
  }

  void _onPhysicalDelayChanged(
      PhysicalDelayChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final isPhysicalDelay = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected =
        event.isChecked || state.isMentalDelay.value || state.isNoLimit.value;
    List<String> updatedOptions = List.from(state.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.add('Körperliche Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Körperliche Entwicklungsverzögerungen');
    }
    emit(
      state.copyWith(
        kidsDevelopState: updatedOptions,
        isPhysicalDelay: isPhysicalDelay,
        isNoLimit: const CheckboxModel.pure(),
        isValid: Formz.validate([state.firstName, state.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onMentalDelayChanged(
      MentalDelayChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final isMentalDelay = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected =
        state.isPhysicalDelay.value || event.isChecked || state.isNoLimit.value;
    List<String> updatedOptions = List.from(state.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.add('GEISTIGE Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('GEISTIGE Entwicklungsverzögerungen');
    }
    emit(
      state.copyWith(
        kidsDevelopState: updatedOptions,
        isMentalDelay: isMentalDelay,
        isNoLimit: const CheckboxModel.pure(),
        isValid: Formz.validate([state.firstName, state.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onNoLimitsChanged(
      NoLimitsChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final isNoLimit = CheckboxModel.dirty(event.isChecked);
    bool isCheckboxSelected = state.isPhysicalDelay.value ||
        state.isMentalDelay.value ||
        event.isChecked;
    List<String> updatedOptions = List.from(state.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.clear();
      updatedOptions.add('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Keine Einschränkungen');
    }
    emit(
      state.copyWith(
        kidsDevelopState: updatedOptions,
        isPhysicalDelay: const CheckboxModel.pure(),
        isMentalDelay: const CheckboxModel.pure(),
        isNoLimit: isNoLimit,
        isValid: Formz.validate([state.firstName, state.lastName]) &&
            isCheckboxSelected,
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<KindPersonalInfoState> emit,
      ) async {
    final firstName = FirstNameModel.dirty(state.firstName.value);
    final lastName = LastNameModel.dirty(state.lastName.value);
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastName,
        isValid: Formz.validate([firstName, lastName]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // await userRepository.updateKidsPersonalInfo(
      //   firstName: state.firstName.value,
      //   lastName: state.lastName.value,
      // );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
