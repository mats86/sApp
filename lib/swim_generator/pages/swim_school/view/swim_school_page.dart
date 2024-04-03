import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/swim_school_bloc.dart';
import 'swim_school_form.dart';

class SwimSchoolPage extends StatelessWidget {
  const SwimSchoolPage({
    super.key,
    required this.graphQLClient,
  });

  final GraphQLClient graphQLClient;

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SwimSchoolPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimSchoolBloc(
          SwimSchoolRepository(graphQLClient: graphQLClient),
        ),
        child: const SwimSchoolForm(),
      ),
    );
  }
}
