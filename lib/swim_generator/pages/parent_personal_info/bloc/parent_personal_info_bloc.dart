import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/models.dart';

part 'parent_personal_info_event.dart';

part 'parent_personal_info_repository.dart';

part 'parent_personal_info_state.dart';

class ParentPersonalInfoBloc
    extends Bloc<ParentPersonalInfoEvent, ParentPersonalInfoState> {
  final ParentPersonalInfoRepository service;

  ParentPersonalInfoBloc(this.service)
      : super(const ParentPersonalInfoState()) {
    on<LoadParentTitleOptions>(_onLoadParentTitleOptions);
    on<TitleChanged>(_onTitleChanged);
    on<ParentFirstNameChanged>(_onParentFirstNameChanged);
    on<ParentLastNameChanged>(_onParentLastNameChanged);
    on<ParentStreetChanged>(_onParentStreetChanged);
    on<ParentStreetNumberChanged>(_onParentStreetNumberChanged);
    on<ParentZipCodeChanged>(_onParentZipCodeChanged);
    on<ParentCityChanged>(_onParentCityChanged);
    on<ParentEmailChanged>(_onParentEmailChanged);
    on<ParentEmailConfirmChanged>(_onParentEmailConfirmChanged);
    on<ParentPhoneNumberChanged>(_onParentPhoneNumberChanged);
    on<ParentPhoneNumberConfirmChanged>(_onParentPhoneNumberConfirmChanged);
    on<IsEmailExists>(_onIsEmailExists);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadParentTitleOptions(LoadParentTitleOptions event,
      Emitter<ParentPersonalInfoState> emit) async {
    emit(state.copyWith(loadingTitleStatus: FormzSubmissionStatus.inProgress));
    try {
      final titleList = await service._fetchTitle();
      emit(state.copyWith(
          titleList: titleList,
          title: TitleModel.dirty(titleList[0]),
          loadingTitleStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingTitleStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onTitleChanged(
    TitleChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final title = TitleModel.dirty(event.title);
    emit(
      state.copyWith(
          title: title,
          isValid: Formz.validate([
            title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentFirstNameChanged(
    ParentFirstNameChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final firstName = FirstNameModel.dirty(event.firstName);
    emit(
      state.copyWith(
          firstName: firstName,
          isValid: Formz.validate(
            [
              state.title,
              firstName,
              state.lastName,
              state.parentStreet,
              state.streetNumber,
              state.zipCode,
              state.city,
              state.email,
              state.emailConfirm,
              state.phoneNumber,
              state.phoneNumberConfirm
            ],
          )),
    );
  }

  void _onParentLastNameChanged(
    ParentLastNameChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final lastName = LastNameModel.dirty(event.lastName);
    emit(
      state.copyWith(
          lastName: lastName,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm,
          ])),
    );
  }

  void _onParentStreetChanged(
    ParentStreetChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final parentStreet = StreetModel.dirty(event.street);
    emit(
      state.copyWith(
          parentStreet: parentStreet,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentStreetNumberChanged(
    ParentStreetNumberChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final streetNumber = StreetNumberModel.dirty(event.streetNumber);
    emit(
      state.copyWith(
          streetNumber: streetNumber,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentZipCodeChanged(
    ParentZipCodeChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final zipCode = ZipCodeModel.dirty(event.zipCode);
    emit(
      state.copyWith(
          zipCode: zipCode,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentCityChanged(
    ParentCityChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final city = CityModel.dirty(event.city);
    emit(
      state.copyWith(
          city: city,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentEmailChanged(
    ParentEmailChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final email = EmailModel.dirty(event.email);
    emit(
      state.copyWith(
          email: email,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentEmailConfirmChanged(
    ParentEmailConfirmChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final emailConfirm = EmailConfirmModel.dirty(
        originalEmail: state.email.value, value: event.emailConfirm);
    emit(
      state.copyWith(
          emailConfirm: emailConfirm,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentPhoneNumberChanged(
    ParentPhoneNumberChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final phoneNumber = PhoneNumberModel.dirty(event.phoneNumber);
    emit(
      state.copyWith(
          phoneNumber: phoneNumber,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            phoneNumber,
            state.phoneNumberConfirm
          ])),
    );
  }

  void _onParentPhoneNumberConfirmChanged(
    ParentPhoneNumberConfirmChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final phoneNumberConfirm = PhoneNumberConfirmModel.dirty(
        value: event.phoneNumberConfirm,
        originalPhoneNumber: state.phoneNumber.value);
    emit(
      state.copyWith(
          phoneNumberConfirm: phoneNumberConfirm,
          isValid: Formz.validate([
            state.title,
            state.firstName,
            state.lastName,
            state.parentStreet,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            phoneNumberConfirm,
          ])),
    );
  }

  void _onIsEmailExists(
      IsEmailExists event,
      Emitter<ParentPersonalInfoState> emit,
      ) {
    if (event.isEmailExists) {
      emit(state.copyWith(
          isEmailExists: event.isEmailExists,
          submissionStatus: FormzSubmissionStatus.success));
    }
    emit(state.copyWith(
        isEmailExists: event.isEmailExists,
        submissionStatus: FormzSubmissionStatus.initial));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<ParentPersonalInfoState> emit,
  ) async {
    final title = TitleModel.dirty(state.title.value);
    final firstName = FirstNameModel.dirty(state.firstName.value);
    final lastName = LastNameModel.dirty(state.lastName.value);
    final parentStreet = StreetModel.dirty(state.parentStreet.value);
    final streetNumber = StreetNumberModel.dirty(state.streetNumber.value);
    final zipCode = ZipCodeModel.dirty(state.zipCode.value);
    final city = CityModel.dirty(state.city.value);
    final email = EmailModel.dirty(state.email.value);
    final emailConfirm = EmailConfirmModel.dirty(
        originalEmail: state.email.value, value: state.emailConfirm.value);
    final phoneNumber = PhoneNumberModel.dirty(state.phoneNumber.value);
    final phoneNumberConfirm = PhoneNumberConfirmModel.dirty(
        value: state.phoneNumberConfirm.value,
        originalPhoneNumber: state.phoneNumberConfirm.value);
    emit(
      state.copyWith(
        title: title,
        firstName: firstName,
        lastName: lastName,
        parentStreet: parentStreet,
        streetNumber: streetNumber,
        zipCode: zipCode,
        city: city,
        email: email,
        emailConfirm: emailConfirm,
        phoneNumber: phoneNumber,
        phoneNumberConfirm: phoneNumberConfirm,
        isValid: Formz.validate([
          title,
          firstName,
          lastName,
          parentStreet,
          streetNumber,
          zipCode,
          city,
          email,
          emailConfirm,
          phoneNumber,
          phoneNumberConfirm
        ]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (await service.checkEmail(state.email.value)) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      } else {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      }
    }
  }
}
