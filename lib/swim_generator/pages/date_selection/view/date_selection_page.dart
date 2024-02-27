import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/date_selection_bloc.dart';
import 'date_selection_form.dart';

class DateSelectionPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const DateSelectionPage({super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => DateSelectionPage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => DateSelectionBloc(
          DateSelectionRepository(graphQLClient: graphQLClient),
        ),
        child: const DateSelectionForm(),
      ),
    );
  }
}
