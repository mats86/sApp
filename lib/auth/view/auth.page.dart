import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/auth/cubit/auth_cubit.dart';

import 'auth_form.dart';

class AuthPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const AuthPage({
    super.key,
    required this.graphQLClient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.currentPage == 1) {
            Navigator.of(context).pushNamed('/login');
          }
        },
        child: AuthForm(graphQLClient: graphQLClient),
      ),
    );
  }
}
