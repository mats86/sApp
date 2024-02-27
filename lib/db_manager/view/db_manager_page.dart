import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../cubit/db_manager_cubit.dart';
import 'db_manager_form.dart';

class DbManagerPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const DbManagerPage({
    super.key,
    required this.graphQLClient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DbManagerCubit>(
      create: (context) => DbManagerCubit(),
      child: BlocListener<DbManagerCubit, DbManagerState>(
        listener: (context, state) {
          if (state.currentPage == 1) {
            Navigator.of(context).pushNamed('/db_swim_course');
          }
        },
        child: DbManagerForm(
          graphQLClient: graphQLClient,
        ),
      ),
    );
  }
}
