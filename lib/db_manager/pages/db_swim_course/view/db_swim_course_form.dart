import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/models.dart';

import '../../../../swim_generator/pages/swim_course/models/swim_course.dart';
import '../../../view/db_manager_shell.dart';
import '../bloc/db_swim_course_bloc.dart';

class DbSwimCourseForm extends StatefulWidget {
  const DbSwimCourseForm({
    super.key,
  });

  @override
  State<DbSwimCourseForm> createState() => _DbSwimCourseForm();
}

class _DbSwimCourseForm extends State<DbSwimCourseForm> {
  @override
  void initState() {
    super.initState();
    context.read<DbSwimCourseBloc>().add(LoadSwimCourseOptions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DbSwimCourseBloc, DbSwimCourseState>(
      listener: (context, state) {
        if (false) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: const ExpandableListViewPage(),
    );
  }
}

class ExpandableListViewPage extends StatelessWidget {
  const ExpandableListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbSwimCourseBloc, DbSwimCourseState>(
        builder: (context, state) {
      Map<int, List<SwimCourse>> groupedCourses = {};
      for (var course in state.swimCourseOptions) {
        groupedCourses.putIfAbsent(course.swimLevelID, () => []).add(course);
      }

      return DbManagerFormShell(
        title: 'Schwimm Kurs',
        child: ListView.builder(
          itemCount: groupedCourses.keys.length,
          itemBuilder: (context, index) {
            int swimLevelID = groupedCourses.keys.elementAt(index);
            List<SwimCourse> courses = groupedCourses[swimLevelID]!;

            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ExpansionTile(
                title: Text(valueOf(swimLevelID-1).name),
                children: courses.map((course) {
                  return ExpansionTile(
                    leading: Icon(
                      Icons.circle,
                      color: course.isSwimCourseVisible
                          ? Colors.green
                          : Colors.red,
                      size: 20.0,
                    ),
                    title: Text(course.swimCourseName),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Beschreibung: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: course.swimCourseDescription,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Duration: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: course.swimCourseDuration,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Alter: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      '${course.swimCourseMinAge} Jahre - ${course.swimCourseMaxAge} Jahre',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      );
    });
  }
}
