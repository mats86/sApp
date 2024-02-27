import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const LoginPage({
    super.key,
    required this.graphQLClient,
  });

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => LoginPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        LoginRepository(graphQLClient: graphQLClient),
      ),
      child: LoginForm(),
    );
  }
}
