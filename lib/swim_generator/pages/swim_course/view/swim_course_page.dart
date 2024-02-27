import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'swim_course_form.dart';

import '../bloc/swim_course_bloc.dart';

class SwimCoursePage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const SwimCoursePage({super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SwimCoursePage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimCourseBloc(
          SwimCourseRepository(graphQLClient: graphQLClient)
        ),
        child: const SwimCourseForm(),
      ),
    );
  }
}
