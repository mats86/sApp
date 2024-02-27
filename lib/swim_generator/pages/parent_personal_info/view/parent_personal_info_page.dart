import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/parent_personal_info_bloc.dart';
import 'parent_personal_info_form.dart';

class ParentPersonalInfoPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const ParentPersonalInfoPage({super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ParentPersonalInfoPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => ParentPersonalInfoBloc(
          ParentPersonalInfoRepository(graphQLClient: graphQLClient),
        ),
        child: const ParentPersonalInfoForm(),
      ),
    );
  }
}
