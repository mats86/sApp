import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../swim_generator/pages/parent_personal_info/models/email_model.dart';

part 'login_event.dart';
part 'login_repository.dart';
part 'login_state.dart';

class LoginBloc  extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(const LoginState());
}