import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../cubit/db_manager_cubit.dart';
import 'db_manager_shell.dart';

class DbManagerForm extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const DbManagerForm({
    super.key,
    required this.graphQLClient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbManagerCubit, DbManagerState>(
        builder: (context, state) {
      return DbManagerFormShell(
        title: 'DB',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<DbManagerCubit>()
                    .navigateToPage(PagesEnum.dbSwimCourse);
              },
              child: const Text('Schwimm Kurse'),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<DbManagerCubit>()
                    .navigateToPage(PagesEnum.dbFixDate);
              },
              child: const Text('FixDates'),
            ),
          ],
        ),
      );
    });
  }
}
