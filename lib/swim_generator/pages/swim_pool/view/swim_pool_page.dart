import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/swim_pool_bloc.dart';
import 'swim_pool_form.dart';

class SwimPoolPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const SwimPoolPage({super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SwimPoolPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimPoolBloc(
          SwimPoolRepository(graphQLClient: graphQLClient),
        ),
        child: const SwimPoolForm(),
      ),
    );
  }
}
