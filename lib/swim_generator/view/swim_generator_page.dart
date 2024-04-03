import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';

import '../cubit/swim_generator_cubit.dart';
import '../models/school_info.dart';

class SwimGeneratorPage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;
  final List<StepPage> order;
  final int swimCourseID;
  final bool isDirectLinks;
  final bool isCodeLinks;
  final String code;
  final SchoolInfo schoolInfo;

  const SwimGeneratorPage({
    super.key,
    required this.graphQLClient,
    required this.title,
    this.order = const [
      StepPage.swimLevel,
      StepPage.swimSeason,
      StepPage.birthDay,
      StepPage.swimCourse,
      StepPage.swimPool,
      StepPage.dateSelection,
      StepPage.kindPersonalInfo,
      StepPage.personalInfo,
      StepPage.result,
    ],
    this.swimCourseID = 0,
    this.isDirectLinks = true,
    this.isCodeLinks = false,
    this.code = '',
    this.schoolInfo = const SchoolInfo(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwimGeneratorCubit>(
      create: (_) => SwimGeneratorCubit(),
      child: SwimGeneratorStepper(
        graphQLClient: graphQLClient,
        order: order,
        swimCourseID: swimCourseID,
        isDirectLinks: isDirectLinks,
        isCodeLinks: isCodeLinks,
        code: code,
        schoolInfo: schoolInfo,
      ),
    );
  }
}
