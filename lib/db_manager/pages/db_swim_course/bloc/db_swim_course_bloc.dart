import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../../../../swim_generator/pages/swim_course/models/swim_course.dart';

part 'db_swim_course_event.dart';
part 'db_swim_course_repository.dart';
part 'db_swim_course_state.dart';

class DbSwimCourseBloc extends Bloc<DbSwimCourseEvent, DbSwimCourseState> {
  final DbSwimCourseRepository service;

  DbSwimCourseBloc(this.service) : super(const DbSwimCourseState()) {
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
  }

  void _onLoadSwimCourseOptions(
      LoadSwimCourseOptions event, Emitter<DbSwimCourseState> emit) async {
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
