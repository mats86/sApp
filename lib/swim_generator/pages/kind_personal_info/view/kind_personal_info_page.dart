import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/kind_personal_info_bloc.dart';
import 'kind_personal_info_form.dart';

class KindPersonalInfoPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const KindPersonalInfoPage(
      {super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => KindPersonalInfoPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => KindPersonalInfoBloc(
          KindPersonalRepository(
            graphQLClient: graphQLClient,
          ),
        ),
        child: const KindPersonalInfoForm(
        ),
      ),
    );
  }
}
