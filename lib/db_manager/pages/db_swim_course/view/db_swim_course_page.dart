import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../bloc/db_swim_course_bloc.dart';
import 'db_swim_course_form.dart';

class DbSwimCoursePage extends StatelessWidget {
  const DbSwimCoursePage({super.key, required this.graphQLClient});
  final GraphQLClient graphQLClient;

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => DbSwimCoursePage(
        graphQLClient: graphQLClient,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DbSwimCourseBloc(
        DbSwimCourseRepository(graphQLClient: graphQLClient),
      ),
      child: const DbSwimCourseForm(),
    );
  }
}
