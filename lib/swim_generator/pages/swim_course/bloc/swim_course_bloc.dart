import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/models/swim_level.dart';
// import 'package:swim_generator_app/swim_generator/pages/swim_course/models/swim_course.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/models.dart';
import '../models/swim_course.dart';

part 'swim_course_event.dart';

part 'swim_course_repository.dart';

part 'swim_course_state.dart';

class SwimCourseBloc extends Bloc<SwimCourseEvent, SwimCourseState> {
  final SwimCourseRepository service;

  SwimCourseBloc(this.service) : super(const SwimCourseState()) {
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<SwimCourseChanged>(_onSwimCourseChanged);
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
    on<DropdownChanged>(_onDropdownChanged);
    on<ActiveMultiChild>(_onActiveMultiChild);
    on<UpdateIsForMultiChild>(_onUpdateIsForMultiChild);
    on<WebPageLoading>(_onWebPageLoading);
    on<WebPageLoaded>(_onWebPageLoaded);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimSeasonChanged(
      SwimSeasonChanged event, Emitter<SwimCourseState> emit) {
    final swimSeason = SwimSeasonModel.dirty(event.swimSeason);
    emit(
      state.copyWith(
        swimSeason: swimSeason,
        isValid: Formz.validate(
          [swimSeason, state.swimCourse],
        ),
      ),
    );
  }

  void _onSwimCourseChanged(
      SwimCourseChanged event, Emitter<SwimCourseState> emit) {
    final swimCourse = SwimCourseModel.dirty(event.swimCourse);
    emit(
      state.copyWith(
        swimCourse: swimCourse,
        selectedCourse: event.course,
        dropdownValue: 1,
        isValid: Formz.validate(
          [state.swimSeason, swimCourse],
        ),
      ),
    );
  }

  void _onLoadSwimSeasonOptions(
      LoadSwimSeasonOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.inProgress));
    try {
      final swimSeason = await service.fetchSwimSeason();
      emit(state.copyWith(
          swimSeasons: swimSeason,
          swimSeason: SwimSeasonModel.dirty(swimSeason[0]),
          loadingSeasonStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onLoadSwimCourseOptions(
      LoadSwimCourseOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.inProgress));
    try {
      final swimCourses =
          await service.getVisibleSwimCoursesByLevelNameAndFutureAge(
              event.swimLevel.toString().split('.')[1],
              event.birthDay,
              event.refDate);
      emit(state.copyWith(
          swimCourseOptions: swimCourses,
          loadingCourseStatus: FormzSubmissionStatus.success));
    } catch (e) {
      if (kDebugMode) {
        print('Fehler beim Laden der Schwimmkurse: $e');
      }
      emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onActiveMultiChild(
    ActiveMultiChild event,
    Emitter<SwimCourseState> emit,
  ) {
    emit(state.copyWith(
        isForMultiChild: state.isForMultiChild ? false : true,
        dropdownValue:
            state.isForMultiChild == false ? 1 : state.dropdownValue));
  }

  void _onUpdateIsForMultiChild(
    UpdateIsForMultiChild event,
    Emitter<SwimCourseState> emit,
  ) {
    emit(state.copyWith(
      isForMultiChild: event.isForMultiChild,
    ));
  }

  void _onDropdownChanged(
    DropdownChanged event,
    Emitter<SwimCourseState> emit,
  ) {
    emit(state.copyWith(dropdownValue: event.dropdownValue));
  }

  // Event-Handler für LoadingWebPage
  void _onWebPageLoading(WebPageLoading event, Emitter<SwimCourseState> emit) {
    emit(
        state.copyWith(loadingWebPageStatus: FormzSubmissionStatus.inProgress));
  }

  // Event-Handler für WebPageLoaded
  Future<void> _onWebPageLoaded(
      WebPageLoaded event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingWebPageStatus: FormzSubmissionStatus.success));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimCourseState> emit) async {
    final inValid = Formz.validate([state.swimSeason, state.swimCourse]);
    if (inValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        // await userRepository.updateSwimCourseInfo(
        //   season: state.swimSeason.value,
        //   swimCourseID: state.selectedCourse.swimCourseID,
        //   swimCourseName: state.selectedCourse.swimCourseName,
        //   swimCoursePrice: state.selectedCourse.swimCoursePrice.toString(),
        // );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
