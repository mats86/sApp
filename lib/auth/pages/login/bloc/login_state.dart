part of 'login_bloc.dart';

class LoginState extends Equatable {
  final EmailModel email;
  final FormzSubmissionStatus submissionStatus;

  const LoginState({
    this.email = const EmailModel.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  LoginState copyWith({
    EmailModel? email,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        submissionStatus,
      ];
}
