import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

enum AuthEnum { unknown, authLogin, authSignup }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void navigateToPage(AuthEnum page) {
    emit(
      state.copyWith(
        currentPage: page.index,
        navigationCounter: state.navigationCounter + 1,
      ),
    );
  }

  void resetPage() {
    emit(
      state.copyWith(currentPage: AuthEnum.authLogin.index),
    );
  }
}
