import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/db_fix_date_bloc.dart';
import 'db_fix_date_form.dart';

class DbFixDatePage extends StatelessWidget {
  const DbFixDatePage({super.key, required this.graphQLClient});
  final GraphQLClient graphQLClient;

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => DbFixDatePage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DbFixDateBloc(
        DbFixDateRepository(graphQLClient: graphQLClient),
      ),
      child: const DbFixDateForm(),
    );
  }
}
