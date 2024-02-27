import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'db_manager_state.dart';

enum PagesEnum { unknown, dbSwimCourse, dbSwimPoll, dbFixDate }

class DbManagerCubit extends Cubit<DbManagerState> {
  DbManagerCubit() : super(const DbManagerState());

  void navigateToPage(PagesEnum page) {
    emit(state.copyWith(
      currentPage: page.index,
      navigationCounter: state.navigationCounter + 1,
    ));
  }

  void resetPage() {
    emit(state.copyWith(
        currentPage: PagesEnum.dbSwimCourse
            .index)); // Sie müssen vielleicht auch den navigationCounter zurücksetzen
  }
}
