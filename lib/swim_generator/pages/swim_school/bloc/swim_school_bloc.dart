import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_school/models/swim_school_model.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/swim_school.dart';

part 'swim_school_event.dart';

part 'swim_school_repository.dart';

part 'swim_school_state.dart';

class SwimSchoolBloc extends Bloc<SwimSchoolEvent, SwimSchoolState> {
  final SwimSchoolRepository service;

  SwimSchoolBloc(this.service) : super(const SwimSchoolState()) {
    on<LoadSwimSchools>(_onLoadSwimSchools);
    on<SelectSwimSchool>(_onSelectSwimSchool);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormCancelled>(_onFormCancelled);
  }

  Future<void> _onLoadSwimSchools(
    LoadSwimSchools event,
    Emitter<SwimSchoolState> emit,
  ) async {
    emit(
        state.copyWith(loadingSwimSchoolStatus: FormzSubmissionStatus.success));
    try {
      final swimSchools = await service.fetchSwimSchools();
      emit(state.copyWith(
          availableSchools: swimSchools,
          loadingSwimSchoolStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(
          loadingSwimSchoolStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onSelectSwimSchool(
    SelectSwimSchool event,
    Emitter<SwimSchoolState> emit,
  ) {
    final selectedSchool = SwimSchoolModel.dirty(event.swimSchoolName);
    emit(state.copyWith(
        swimSchoolSelected: selectedSchool,
        swimSchool: event.swimSchool,
        swimSchoolUrl: event.swimSchool.swimSchoolUrl,
        isValid: Formz.validate([selectedSchool])));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<SwimSchoolState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }

  void _onFormCancelled(
    FormCancelled event,
    Emitter<SwimSchoolState> emit,
  ) {
    emit(state.copyWith(cancellationStatus: FormzSubmissionStatus.inProgress));
    emit(state.copyWith(cancellationStatus: FormzSubmissionStatus.success));
  }
}
