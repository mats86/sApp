import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../cubit/auth_cubit.dart';
import 'auth_form_shell.dart';

class AuthForm extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const AuthForm({
    super.key,
    required this.graphQLClient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return AuthFormShell(
            title: 'DB',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .navigateToPage(AuthEnum.authLogin);
                  },
                  child: const Text('Schwimm Kurse'),
                ),
              ],
            ),
          );
        });
  }
}