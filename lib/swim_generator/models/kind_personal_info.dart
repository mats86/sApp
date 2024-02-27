import 'package:equatable/equatable.dart';

class KindPersonalInfo extends Equatable {
  final String firstName;
  final String lastName;
  final List<String> kidsDevelopState;

  const KindPersonalInfo({
    required this.firstName,
    required this.lastName,
    required this.kidsDevelopState,
  });

  const KindPersonalInfo.empty()
      : this(
    firstName: '',
    lastName: '',
    kidsDevelopState: const [],
  );

  KindPersonalInfo copyWith({
    String? firstName,
    String? lastName,
    List<String>? kidsDevelopState,
  }) {
    return KindPersonalInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      kidsDevelopState: kidsDevelopState ?? this.kidsDevelopState,
    );
  }

  bool get isEmpty {
    return firstName.isEmpty && lastName.isEmpty && kidsDevelopState.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object> get props => [
    firstName,
    lastName,
    kidsDevelopState,
  ];
}
