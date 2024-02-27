import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_level/bloc/swim_level_bloc.dart';

import 'swim_level_form.dart';

class SwimLevelPage extends StatelessWidget {
  final bool isDirectLinks;
  final SchoolInfo schoolInfo;

  const SwimLevelPage({
    super.key,
    required this.isDirectLinks,
    required this.schoolInfo,
  });

  route() {
    return MaterialPageRoute<void>(
      builder: (_) => SwimLevelPage(
        isDirectLinks: isDirectLinks,
        schoolInfo: schoolInfo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimLevelBloc(),
        child: SwimLevelForm(
          isDirectLinks: isDirectLinks,
          schoolInfo: schoolInfo,
        ),
      ),
    );
  }
}
