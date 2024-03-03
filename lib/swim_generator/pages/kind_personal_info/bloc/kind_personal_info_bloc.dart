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
    on<UpdateChildInfoIndex>(_onUpdateChildInfoIndex);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<PhysicalDelayChanged>(_onPhysicalDelayChanged);
    on<MentalDelayChanged>(_onMentalDelayChanged);
    on<NoLimitsChanged>(_onNoLimitsChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onUpdateChildInfoIndex(
    UpdateChildInfoIndex event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    List<ChildInfo> childInfos = List<ChildInfo>.from(state.childInfos);
    childInfos.add(const ChildInfo());
    emit(state.copyWith(
        childInfos: childInfos, childInfoIndex: state.childInfoIndex + 1));
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    List<ChildInfo> updatedChildInfos = List<ChildInfo>.from(state.childInfos);

    final updatedFirstName = FirstNameModel.dirty(event.firstName);
    updatedChildInfos[event.index] =
        updatedChildInfos[event.index].copyWith(firstName: updatedFirstName);

    final isValid = updatedChildInfos.every((childInfo) =>
        Formz.validate([childInfo.firstName, childInfo.lastName]));

    emit(
      state.copyWith(
        childInfos: updatedChildInfos,
        isValid: isValid,
      ),
    );
  }

  void _onFirstNameUnfocused(
    FirstNameUnfocused event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    // final firstName = FirstNameModel.dirty(state.firstName.value);
    // emit(state.copyWith(
    //   firstName: firstName,
    //   isValid: Formz.validate([firstName, state.lastName]),
    // ));
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    List<ChildInfo> updatedChildInfos = List<ChildInfo>.from(state.childInfos);

    final updatedLastName = LastNameModel.dirty(event.lastName);
    updatedChildInfos[event.index] =
        updatedChildInfos[event.index].copyWith(lastName: updatedLastName);

    bool isValid = updatedChildInfos.every((childInfo) {
      return Formz.validate([
        childInfo.firstName,
        childInfo.lastName,
      ]);
    });

    emit(
      state.copyWith(
        childInfos: updatedChildInfos,
        isValid: isValid,
      ),
    );
  }

  void _onLastNameUnfocused(
    LastNameUnfocused event,
    Emitter<KindPersonalInfoState> emit,
  ) {}

  void _onPhysicalDelayChanged(
    PhysicalDelayChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final List<ChildInfo> updatedChildInfos =
        List<ChildInfo>.from(state.childInfos);
    final currentChildInfo = updatedChildInfos[event.index];
    final updatedIsPhysicalDelay = CheckboxModel.dirty(event.isChecked);
    final updatedChildInfo = currentChildInfo.copyWith(
      isPhysicalDelay: updatedIsPhysicalDelay,
    );

    List<String> updatedOptions =
        List<String>.from(currentChildInfo.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.add('Körperliche Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Körperliche Entwicklungsverzögerungen');
    }

    updatedChildInfos[event.index] =
        updatedChildInfo.copyWith(kidsDevelopState: updatedOptions);

    bool isCheckboxSelected = updatedChildInfos.any((childInfo) =>
        childInfo.isPhysicalDelay.value ||
        childInfo.isMentalDelay.value ||
        childInfo.isNoLimit.value);

    bool isValid = updatedChildInfos.every((childInfo) {
      return Formz.validate([
        childInfo.firstName,
        childInfo.lastName,
      ]);
    });

    emit(
      state.copyWith(
        childInfos: updatedChildInfos,
        isValid: isValid,
      ),
    );
  }

  void _onMentalDelayChanged(
    MentalDelayChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    List<ChildInfo> updatedChildInfos = List<ChildInfo>.from(state.childInfos);

    final currentChildInfo = updatedChildInfos[event.index];
    final updatedIsMentalDelay = CheckboxModel.dirty(event.isChecked);

    List<String> updatedOptions =
        List<String>.from(currentChildInfo.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.add('GEISTIGE Entwicklungsverzögerungen');
      updatedOptions.remove('Keine Einschränkungen');
    } else {
      updatedOptions.remove('GEISTIGE Entwicklungsverzögerungen');
    }

    final updatedChildInfo = currentChildInfo.copyWith(
      isMentalDelay: updatedIsMentalDelay,
      kidsDevelopState: updatedOptions,
    );

    updatedChildInfos[event.index] = updatedChildInfo;

    bool isCheckboxSelected = updatedChildInfos.any((childInfo) =>
        childInfo.isPhysicalDelay.value ||
        childInfo.isMentalDelay.value ||
        childInfo.isNoLimit.value);

    emit(
      state.copyWith(
        childInfos: updatedChildInfos,
        isValid: updatedChildInfos.every((childInfo) =>
            Formz.validate([childInfo.firstName, childInfo.lastName]) &&
            (childInfo.isPhysicalDelay.value ||
                childInfo.isMentalDelay.value ||
                childInfo.isNoLimit.value)),
      ),
    );
  }

  void _onNoLimitsChanged(
    NoLimitsChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    List<ChildInfo> updatedChildInfos = List<ChildInfo>.from(state.childInfos);

    final currentChildInfo = updatedChildInfos[event.index];
    final updatedIsNoLimit = CheckboxModel.dirty(event.isChecked);

    List<String> updatedOptions =
        List<String>.from(currentChildInfo.kidsDevelopState);
    if (event.isChecked) {
      updatedOptions.clear();
      updatedOptions.add('Keine Einschränkungen');
    } else {
      updatedOptions.remove('Keine Einschränkungen');
    }

    final updatedChildInfo = currentChildInfo.copyWith(
      isNoLimit: updatedIsNoLimit,
      kidsDevelopState: updatedOptions,
      isPhysicalDelay: event.isChecked
          ? const CheckboxModel.pure()
          : currentChildInfo.isPhysicalDelay,
      isMentalDelay: event.isChecked
          ? const CheckboxModel.pure()
          : currentChildInfo.isMentalDelay,
    );

    updatedChildInfos[event.index] = updatedChildInfo;

    emit(
      state.copyWith(
        childInfos: updatedChildInfos,
        isValid: updatedChildInfos.every((childInfo) =>
            Formz.validate([childInfo.firstName, childInfo.lastName]) &&
            (childInfo.isPhysicalDelay.value ||
                childInfo.isMentalDelay.value ||
                childInfo.isNoLimit.value)),
      ),
    );
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    // final firstName = FirstNameModel.dirty(state.firstName.value);
    // final lastName = LastNameModel.dirty(state.lastName.value);
    // emit(
    //   state.copyWith(
    //     firstName: firstName,
    //     lastName: lastName,
    //     isValid: Formz.validate([firstName, lastName]),
    //   ),
    // );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
