import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../bloc/swim_season_bloc.dart';
import '../models/swim_season.dart';

class SwimSeasonForm extends StatefulWidget {
  const SwimSeasonForm({
    super.key,
  });

  @override
  State<SwimSeasonForm> createState() => _SwimSeasonForm();
}

class _SwimSeasonForm extends State<SwimSeasonForm> {
  @override
  void initState() {
    super.initState();
    // DateTime now = DateTime(2024, 3, 1, 00, 01);
    DateTime now = DateTime.now();
    int year = now.year;
    DateTime startSeason =
    DateTime(year, 3, 1, 00, 00); // 31.1 23:59 end january
    DateTime endSeason = DateTime(year, 8, 31, 23, 59); // 31.8 23:59 end August

    DateTime startFixDate = DateTime(year, 2, 1, 00, 00);

    context.read<SwimGeneratorCubit>().updateConfigApp(
      isBooking: now.isAfter(startSeason) && now.isBefore(endSeason)
          ? true
          : false,
      isStartFixDate: now.isAfter(startFixDate) && now.isBefore(endSeason)
          ? true
          : false,
      isEmailExists: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimSeasonBloc, SwimSeasonState>(
      listener: (context, state) {
        if (state.submissionStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const _SwimSeasonRadioButton(),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: _SubmitButton())
            ],
          )
        ],
      ),
    );
  }
}

class _SwimSeasonRadioButton extends StatelessWidget {
  const _SwimSeasonRadioButton();

  @override
  Widget build(BuildContext context) {
    String getSeasonText() {
      if (context.read<SwimGeneratorCubit>().state.configApp.isBooking) {
        context.read<SwimSeasonBloc>().add(
          LoadSwimSeasonOptions(
            [
              SwimSeason(
                name: 'Für laufenden Sommer Saison buchen',
                refDate: DateTime(DateTime.now().year, 6, 1),
                swimSeasonEnum: SwimSeasonEnum.BUCHEN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 1))} reservieren',
                refDate: DateTime(DateTime.now().year + 1, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 2))} reservieren',
                refDate: DateTime(DateTime.now().year + 2, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 3))} reservieren',
                refDate: DateTime(DateTime.now().year + 3, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
            ],
          ),
        );
        return 'Möchtest Du in der Kommenden Saison starten?';
      } else {
        context.read<SwimSeasonBloc>().add(
          LoadSwimSeasonOptions(
            [
              SwimSeason(
                name: 'Buchen/Reservieren für Sommersaison 2024',
                refDate: DateTime(DateTime.now().year, 6, 1),
                swimSeasonEnum: SwimSeasonEnum.BUCHEN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 1))} reservieren',
                refDate: DateTime(DateTime.now().year + 1, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 2))} reservieren',
                refDate: DateTime(DateTime.now().year + 2, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
              SwimSeason(
                name:
                'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 3))} reservieren',
                refDate: DateTime(DateTime.now().year + 3, 6),
                swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
              ),
            ],
          ),
        );
        return 'In WELCHER Somersaison möchtest Du starten?';
      }
    }

    return BlocBuilder<SwimSeasonBloc, SwimSeasonState>(
        builder: (context, state) {
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: getSeasonText(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.visible,
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        separatorBuilder: (_, __) =>
                            Divider(color: Colors.grey[300]),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.swimSeasonOptions.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            // height: 50,
                            child: Visibility(
                              visible: true,
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.lightBlueAccent,
                                    groupValue: state.swimSeason.value,
                                    value: state.swimSeasonOptions[index].name,
                                    onChanged: (val) {
                                      BlocProvider.of<SwimSeasonBloc>(context).add(
                                          SwimSeasonChanged(val.toString(),
                                              state.swimSeasonOptions[index]));
                                    },
                                  ),
                                  Flexible(
                                    child: Wrap(
                                      children: [
                                        Text(
                                          '${state.swimSeasonOptions[index].name} ',
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimSeasonBloc, SwimSeasonState>(
      listenWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context
              .read<SwimGeneratorCubit>()
              .updateSwimSeasonInfo(state.selectedSwimSeason);
          context.read<SwimGeneratorCubit>().updateConfigApp(
              isBooking: state.selectedSwimSeason.swimSeasonEnum ==
                  SwimSeasonEnum.BUCHEN
                  ? true
                  : false);
        }
      },
      buildWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
        context.select((SwimSeasonBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
          color: Colors.lightBlueAccent,
          size: 50.0,
        )
            : ElevatedButton(
          key: const Key(
              'kindPersonalInfoForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.lightBlueAccent),
          onPressed: isValid
              ? () => context.read<SwimSeasonBloc>().add(FormSubmitted())
              : null,
          child: const Text(
            'Weiter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimSeasonBloc, SwimSeasonState>(
        buildWhen: (previous, current) =>
        previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
            key: const Key(
                'kindPersonalInfoForm_cancelButton_elevatedButton'),
            onPressed: () =>
                context.read<SwimGeneratorCubit>().stepCancelled(),
            child: const Text(
              'Abrechen',
            ),
          );
        });
  }
}
