import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/pages/date_selection/view/date_selection_page.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_school/view/swim_school_page.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_season/view/swim_season_page.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_form_shell.dart';

import '../cubit/swim_generator_cubit.dart';
import '../pages/pages.dart';

class SwimGeneratorStepper extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final List<StepPage> order;
  final int swimCourseID;
  final bool isDirectLinks;
  final bool isCodeLinks;
  final String code;
  final SchoolInfo schoolInfo;

  const SwimGeneratorStepper({
    super.key,
    required this.graphQLClient,
    required this.order,
    required this.swimCourseID,
    required this.isDirectLinks,
    required this.isCodeLinks,
    required this.code,
    required this.schoolInfo,
  });

  @override
  Widget build(BuildContext context) {
    context.read<SwimGeneratorCubit>().updateStepPages(order);
    context.read<SwimGeneratorCubit>().updateStepperLength(order.length);
    context.read<SwimGeneratorCubit>().updateNumberStepper(order.length);
    context
        .read<SwimGeneratorCubit>()
        .updateConfigApp(isDirectLinks: isDirectLinks, isCodeLinks: isCodeLinks, code: code);
    return BlocBuilder<SwimGeneratorCubit, SwimGeneratorState>(
      builder: (context, state) {
        context.read<SwimGeneratorCubit>().updateStepPages(state.stepPages);
        context
            .read<SwimGeneratorCubit>()
            .updateStepperLength(state.stepPages.length);
        context
            .read<SwimGeneratorCubit>()
            .updateNumberStepper(state.stepPages.length);
        if (isCodeLinks) {
          context.read<SwimGeneratorCubit>().updateAddStepPages(1);
        }
        return SwimGeneratorFormShell(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: false,
                activeStepColor: Colors.lightBlueAccent,
                numbers: state.numberStepper,
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SwimGeneratorCubit>().stepTapped(index);
                },
              ),
              header(
                state.activeStepperIndex,
                state.stepPages.isEmpty ? order : state.stepPages,
                context.read<SwimGeneratorCubit>().state.configApp.isBooking,
                state.swimCourseInfo.swimCourse.isAdultCourse,
                state.swimCourseInfo.isForMultiChild,
                state.childInfoIndex,
              ),
              body(
                state.activeStepperIndex,
                state.stepPages.isEmpty ? order : state.stepPages,
                swimCourseID,
                state.swimCourseInfo.swimCourse.isAdultCourse,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header(
    int activeStepperIndex,
    List<StepPage> stepPages,
    bool isBooking,
    bool isAdultCourse,
    bool isGroupCourse,
    int childInfoIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(
            activeStepperIndex,
            stepPages,
            isBooking,
            isAdultCourse,
            isGroupCourse,
            childInfoIndex,
          ),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(
    int activeStepperIndex,
    List<StepPage> stepPages,
    bool isBooking,
    bool isAdultCourse,
    bool isGroupCourse,
    int childInfoIndex,
  ) {
    StepPage page = stepPages[activeStepperIndex];

    switch (page) {
      case StepPage.swimSchool:
        return 'Schwimmschule';

      case StepPage.swimLevel:
        return 'Schwimmniveau';

      case StepPage.swimSeason:
        return 'TERMIN-WAHL';

      case StepPage.birthDay:
        return 'Geburtsdatum';

      case StepPage.swimCourse:
        return 'Schwimmkurs';

      case StepPage.swimPool:
        return 'Schwimmbad';

      case StepPage.dateSelection:
        if (isBooking) {
          return 'TERMINWAHL';
        } else {
          return 'Hinweis Verein';
        }

      case StepPage.kindPersonalInfo:
        if (isAdultCourse) {
          return 'DATEN zum FREUND';
        } else {
          if (isGroupCourse) {
            return 'DATEN zum ${childInfoIndex + 1}. SCHWIMSCHÜLER:IN';
          } else {
            return 'DATEN zum SCHWIMSCHÜLER:IN';
          }
        }

      case StepPage.personalInfo:
        if (isAdultCourse) {
          return 'Deine erfassten Daten';
        } else {
          return 'Erziehungsberechtigten Information';
        }

      case StepPage.result:
        return 'Deine erfassten Daten';

      default:
        return '';
    }
  }

  /// Returns the body.
  Widget body(
    int activeStepperIndex,
    List<StepPage> stepPages,
    int swimCourseID,
    bool isAdultCourse,
  ) {
    StepPage page = stepPages[activeStepperIndex];

    switch (page) {
      case StepPage.swimSchool:
        return SwimSchoolPage(graphQLClient: graphQLClient);

      case StepPage.swimLevel:
        return const SwimLevelPage(
        );

      case StepPage.swimSeason:
        return const SwimSeasonPage();

      case StepPage.birthDay:
        return BirthDayPage(
          swimCourseID: swimCourseID,
          graphQLClient: graphQLClient,
        );

      case StepPage.swimCourse:
        return SwimCoursePage(graphQLClient: graphQLClient);

      case StepPage.swimPool:
        return SwimPoolPage(graphQLClient: graphQLClient);

      case StepPage.dateSelection:
        return DateSelectionPage(graphQLClient: graphQLClient);

      case StepPage.kindPersonalInfo:
        return KindPersonalInfoPage(
            key: UniqueKey(),
            graphQLClient: graphQLClient);

      case StepPage.personalInfo:
        return ParentPersonalInfoPage(
          graphQLClient: graphQLClient,
        );

      case StepPage.result:
        return ResultPage(graphQLClient: graphQLClient);

      default:
        return Container();
    }
  }
}

enum StepPage {
  swimSchool,
  swimLevel,
  swimSeason,
  birthDay,
  swimCourse,
  swimPool,
  dateSelection,
  personalInfo,
  kindPersonalInfo,
  result,
}
