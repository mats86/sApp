part of 'db_manager_cubit.dart';

class DbManagerState extends Equatable {
  final int currentPage;
  final int navigationCounter; // Eine neue Variable

  const DbManagerState({this.currentPage = 1, this.navigationCounter = 0});

  @override
  List<Object?> get props => [currentPage, navigationCounter];

  DbManagerState copyWith({int? currentPage, int? navigationCounter}) {
    return DbManagerState(
      currentPage: currentPage ?? this.currentPage,
      navigationCounter: navigationCounter ?? this.navigationCounter,
    );
  }
}
