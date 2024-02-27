part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final int currentPage;
  final int navigationCounter;

  const AuthState({
    this.currentPage = 1,
    this.navigationCounter = 0,
  });

  @override
  List<Object?> get props => [currentPage, navigationCounter];

  AuthState copyWith({
    int? currentPage,
    int? navigationCounter,
  }) {
    return AuthState(
      currentPage: currentPage ?? this.currentPage,
      navigationCounter: navigationCounter ?? this.navigationCounter,
    );
  }
}
