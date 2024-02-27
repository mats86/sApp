import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/result/models/verein_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/checkbox_model.dart';
import '../models/complete_swim_course_booking_input.dart';
import '../models/create_contact_input.dart';

part 'result_event.dart';

part 'result_repository.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultRepository service;

  ResultBloc(this.service) : super(const ResultState()) {
    on<ResultLoading>(_onResultLoading);
    on<ConfirmedChanged>(_onConfirmedChanged);
    on<CancellationChanged>(_onCancellationChanged);
    on<ConsentGDPRChanged>(_onConsentGDPRChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSubmittedVerein>(_onFormSubmittedVerein);
  }

  void _onResultLoading(
      ResultLoading event,
      Emitter<ResultState> emit,
      ) {
    emit(state.copyWith(isBooking: event.isBooking));
  }

  void _onConfirmedChanged(
      ConfirmedChanged event,
      Emitter<ResultState> emit,
      ) {
    final isConfirmed = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
      isConfirmed: isConfirmed,
      isValid: state.isBooking
          ? Formz.validate(
          [isConfirmed, state.isCancellation, state.isConsentGDPR])
          : Formz.validate([isConfirmed, state.isConsentGDPR]),
    ));
  }

  void _onCancellationChanged(
      CancellationChanged event,
      Emitter<ResultState> emit,
      ) {
    final isCancellation = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
        isCancellation: isCancellation,
        isValid: Formz.validate(
            [state.isConfirmed, isCancellation, state.isConsentGDPR])));
  }

  void _onConsentGDPRChanged(
      ConsentGDPRChanged event,
      Emitter<ResultState> emit,
      ) {
    final isConsentGDPR = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
      isConsentGDPR: isConsentGDPR,
      isValid: state.isBooking
          ? Formz.validate(
          [state.isConfirmed, state.isCancellation, isConsentGDPR])
          : Formz.validate([state.isConfirmed, isConsentGDPR]),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<ResultState> emit,
      ) async {
    final isConfirmed = CheckboxModel.dirty(state.isConfirmed.value);
    final isConsentGDPR = CheckboxModel.dirty(state.isConsentGDPR.value);
    if (state.isBooking) {
      emit(
        state.copyWith(
          isConfirmed: isConfirmed,
          isCancellation: CheckboxModel.dirty(state.isCancellation.value),
          isConsentGDPR: isConsentGDPR,
          isValid: Formz.validate([
            isConfirmed,
            CheckboxModel.dirty(state.isCancellation.value),
            isConsentGDPR
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isConfirmed: isConfirmed,
          isConsentGDPR: isConsentGDPR,
          isValid: Formz.validate([isConfirmed, isConsentGDPR]),
        ),
      );
    }
    bool bSuccess;
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (event.isEmailExists) {
        bSuccess = await service.executeBookingForExistingGuardian(
          NewStudentAndBookingInput(
            loginEmail: event.completeSwimCourseBookingInput.loginEmail,
            studentFirstName:
            event.completeSwimCourseBookingInput.studentFirstName,
            studentLastName:
            event.completeSwimCourseBookingInput.studentLastName,
            birthDate: event.completeSwimCourseBookingInput.birthDate,
            swimCourseID: event.completeSwimCourseBookingInput.swimCourseID,
            swimPoolIDs: event.completeSwimCourseBookingInput.swimPoolIDs,
            referenceBooking:
            event.completeSwimCourseBookingInput.referenceBooking,
            fixDateID: event.completeSwimCourseBookingInput.fixDateID,
          ),
        );
      } else {
        bSuccess = await service.createContact(event.contactInputBrevo);
        if (!bSuccess) {
          // if Handynummer not valid, save without Handynummer
          bSuccess = await service.createContact(CreateContactInput(
            email: event.contactInputBrevo.email,
            firstName: event.contactInputBrevo.firstName,
            lastName: event.contactInputBrevo.lastName,
            sms: '',
            listIds: [2],
            emailBlacklisted: false,
            smsBlacklisted: false,
            updateEnabled: false,
            smtpBlacklistSender: [event.contactInputBrevo.email],
          ));
        }
        bSuccess = await service.executeCreateCompleteSwimCourseBooking(
            event.completeSwimCourseBookingInput);
      }
      if (bSuccess) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      }
    }
  }

  void _onFormSubmittedVerein(
      FormSubmittedVerein event,
      Emitter<ResultState> emit,
      ) async {
    // Konstruieren der URL mit Query-Parametern basierend auf event.vereinInput
    var queryParams = {
      'panrede': event.vereinInput.panrede,
      'pvorname': event.vereinInput.pvorname,
      'pname': event.vereinInput.pname,
      'pstrasse': event.vereinInput.pstrasse,
      'pplz': event.vereinInput.pplz,
      'port': event.vereinInput.port,
      'pmobil': event.vereinInput.pmobil,
      'pemail': event.vereinInput.pemail,
      'pgebdatum': event.vereinInput.pgebdatum,
      'pcfield1': event.vereinInput.pcfield1,
      'pcfield2': event.vereinInput.pcfield2,
      'pcfield3': event.vereinInput.pcfield3,
      'pcfield4': event.vereinInput.pcfield4,
      'pcfield5': event.vereinInput.pcfield5,
      'pcfield6': event.vereinInput.pcfield6,
    };

    var uri =
    Uri.https('wassermenschen-verein.de', '/mitglied-werden/', queryParams);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
