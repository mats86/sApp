import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/school_info.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_level/bloc/swim_level_bloc.dart';

import 'swim_level_form.dart';

class SwimLevelPage extends StatelessWidget {

  const SwimLevelPage({
    super.key,
  });

  route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SwimLevelPage(
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimLevelBloc(),
        child: const SwimLevelForm(
        ),
      ),
    );
  }
}
