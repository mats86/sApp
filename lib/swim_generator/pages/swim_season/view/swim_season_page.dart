import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/swim_season_bloc.dart';
import 'swim_season_form.dart';

class SwimSeasonPage extends StatelessWidget {
  const SwimSeasonPage({
    super.key,
  });

  route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SwimSeasonPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimSeasonBloc(),
        child: const SwimSeasonForm(),
      ),
    );
  }
}
