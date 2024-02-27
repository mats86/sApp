import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../../../../swim_generator/pages/date_selection/model/model.dart';
import '../../../../swim_generator/pages/swim_course/models/swim_course.dart';

part 'db_fix_date_event.dart';
part 'db_fix_date_repository.dart';
part 'db_fix_date_state.dart';

class DbFixDateBloc extends Bloc<DbFixDateEvent, DbFixDateState> {
  final DbFixDateRepository service;

  DbFixDateBloc(this.service) : super(const DbFixDateState()) {
    on<LoadFixDateOptions>(_onLoadFixDateOptions);
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
  }

  void _onLoadFixDateOptions(
      LoadFixDateOptions event, Emitter<DbFixDateState> emit) async {
    emit(
        state.copyWith(loadingFixDateStatus: FormzSubmissionStatus.inProgress));
    try {
      final fixDates = await service.getFixDatesWithDetails();
      emit(state.copyWith(
          fixDateOptions: fixDates,
          loadingFixDateStatus: FormzSubmissionStatus.success));
    } catch (e) {
      // Hier können Sie spezifische Fehler loggen
      if (kDebugMode) {
        print('Fehler beim Laden der Schwimmkurse: $e');
      }
      emit(state.copyWith(loadingFixDateStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onLoadSwimCourseOptions(
      LoadSwimCourseOptions event, Emitter<DbFixDateState> emit) async {
    emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.inProgress));
    try {
      final swimCourses = await service.getSwimCourses();
      emit(state.copyWith(
          swimCourseOptions: swimCourses,
          loadingCourseStatus: FormzSubmissionStatus.success));
    } catch (e) {
      // Hier können Sie spezifische Fehler loggen
      if (kDebugMode) {
        print('Fehler beim Laden der Schwimmkurse: $e');
      }
      emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.failure));
    }
  }
}
