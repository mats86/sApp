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
import '../models/swim_course_booking_result.dart';

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
    bool bSuccess = false;
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (event.isEmailExists) {
        bSuccess = await service.executeBookingForExistingGuardian(
          NewStudentAndBookingInput(
            loginEmail: event.completeSwimCourseBookingInput.loginEmail,
            studentFirstName: event
                .completeSwimCourseBookingInput.childInfos[0].firstName.value,
            studentLastName: event
                .completeSwimCourseBookingInput.childInfos[0].lastName.value,
            birthDate: event.completeSwimCourseBookingInput.birthDate,
            swimCourseID: event.completeSwimCourseBookingInput.swimCourseID,
            swimPoolIDs: event.completeSwimCourseBookingInput.swimPoolIDs,
            referenceBooking:
                event.completeSwimCourseBookingInput.referenceBooking,
            fixDateID: event.completeSwimCourseBookingInput.fixDateID,
          ),
        );
      } else {
        var swimCourseBookingResult = await service.executeCreateCompleteSwimCourseBooking(
            event.completeSwimCourseBookingInput);

        if (swimCourseBookingResult.isSuccess) {
          bSuccess = await service.createOrUpdateContact(CreateContactInput(
            email: event.contactInputBrevo.email,
            firstName: event.contactInputBrevo.firstName,
            lastName: event.contactInputBrevo.lastName,
            childFirstName: event.contactInputBrevo.childFirstName,
            childBirthDay: event.contactInputBrevo.childBirthDay,
            sms: event.contactInputBrevo.sms,
            whatsapp: event.contactInputBrevo.whatsapp,
            listIds: event.contactInputBrevo.listIds,
            emailBlacklisted: event.contactInputBrevo.emailBlacklisted,
            smsBlacklisted: event.contactInputBrevo.smsBlacklisted,
            updateEnabled: event.contactInputBrevo.updateEnabled,
            smtpBlacklistSender: [event.contactInputBrevo.email],
            swimCourse: event.contactInputBrevo.swimCourse,
            swimPool: event.contactInputBrevo.swimPool,
            fixDate: event.contactInputBrevo.fixDate,
            isWaitList: swimCourseBookingResult.swimCourseBookingData?.isWaitList,

          ));
          if(bSuccess && event.completeSwimCourseBookingInput.customerInvitedInfos.isNotEmpty)
            {
              bSuccess = await service.createContacts(CreateContactsInput(
                customerInvitedInfos: event.completeSwimCourseBookingInput.customerInvitedInfos,
                listIds: event.contactInputBrevo.listIds,
                emailBlacklisted: event.contactInputBrevo.emailBlacklisted,
                smsBlacklisted: event.contactInputBrevo.smsBlacklisted,
                updateEnabled: event.contactInputBrevo.updateEnabled,
                smtpBlacklistSender: [event.contactInputBrevo.email],
                swimCourse: event.contactInputBrevo.swimCourse,
                swimPool: event.contactInputBrevo.swimPool,
                fixDate: event.contactInputBrevo.fixDate,
                isWaitList: swimCourseBookingResult.swimCourseBookingData?.isWaitList,
                inviteCode: swimCourseBookingResult.swimCourseBookingData?.inviteCode));
            }
        }
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
