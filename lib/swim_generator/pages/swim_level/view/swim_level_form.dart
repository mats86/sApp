import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_level/bloc/swim_level_bloc.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../../../models/school_info.dart';
import '../../../models/swim_level.dart';
import '../models/models.dart';

class SwimLevelForm extends StatefulWidget {
  final bool isDirectLinks;
  final SchoolInfo schoolInfo;

  const SwimLevelForm({
    super.key,
    required this.isDirectLinks,
    required this.schoolInfo,
  });

  @override
  State<SwimLevelForm> createState() => _SwimLevelForm();
}

class _SwimLevelForm extends State<SwimLevelForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimLevelBloc>().add(IsDirectLinks(widget.isDirectLinks));

    SwimLevelEnum swimLevel =
    context.read<SwimGeneratorCubit>().state.swimLevel.swimLevel!;
    if (swimLevel != SwimLevelEnum.UNDEFINED) {
      context.read<SwimLevelBloc>().add(SwimLevelChanged(
          SwimLevelModel.dirty(SwimLevelEnum.values[swimLevel.index])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimLevelBloc, SwimLevelState>(
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
          if (!widget.isDirectLinks) ...[
            const SizedBox(
              height: 16.0,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Wähle bitte Dein Schwimmniveau aus?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
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
            const SizedBox(
              height: 24.0,
            ),
            const _SwimLevelSelected(),
            const SwimLevelRadioButtonClass(),
          ],
          const SizedBox(
            height: 32.0,
          ),
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

class _SwimLevelSelected extends StatelessWidget {
  const _SwimLevelSelected();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
      buildWhen: (previous, current) =>
      previous.swimLevelModel != current.swimLevelModel,
      builder: (context, state) {
        List<bool> isSelected = [
          state.swimLevelModel.value == SwimLevelEnum.EINSTEIGERKURS,
          state.swimLevelModel.value == SwimLevelEnum.AUFSTEIGERKURS,
        ];

        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildToggleButton(
                  Icons.waves, " EINSTEIGER", isSelected[0], 0, context),
              const SizedBox(width: 8.0),
              _buildToggleButton(
                  Icons.pool, "AUFSTEIGER", isSelected[1], 1, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton(IconData icon, String text, bool isSelected,
      int index, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String buttonText = screenWidth > 500 ? "${text}KURS" : text;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: TextButton(
        onPressed: () {
          context.read<SwimLevelBloc>().add(SwimLevelChanged(
              SwimLevelModel.dirty(SwimLevelEnum.values[index])));
          if (SwimLevelEnum.values[index] == SwimLevelEnum.EINSTEIGERKURS) {
            context.read<SwimLevelBloc>().add(const LoadSwimLevelOptions([]));
            context.read<SwimLevelBloc>().add(
              LoadSwimLevelOptions(
                [
                  SwimLevelRadioButton(
                    name: 'ist völliger Schwimmanfänger',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name: 'hat Spritzwasser Erfahrung',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name:
                    'kann gut Tauchen und Unterwasser schwimmen. Über Wasser geht es noch nicht',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name:
                    'kann schon schwimmen - braucht allerdings noch Unterstützung durch Schwimmhilfen',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name:
                    'kann schon schwimmen - kann sich allerdings noch nicht über Wasser halten',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name: 'kann schon ein paar Meter (ca. 5m ) schwimmen',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name: 'kann schon schwimmen (ca. 10m )',
                    isChecked: false,
                  ),
                  SwimLevelRadioButton(
                    name:
                    'kann bereits mehr als 10 m schwimmen - hat aber noch kein Seepferdchen',
                    isChecked: false,
                  ),
                ],
              ),
            );
          } else {
            BlocProvider.of<SwimLevelBloc>(context).add(
              const SwimLevelRBChanged(
                '',
                SwimLevelRadioButton.empty(),
              ),
            );
            context.read<SwimLevelBloc>().add(const LoadSwimLevelOptions([]));
            context.read<SwimLevelBloc>().add(
              LoadSwimLevelOptions(
                [
                  SwimLevelRadioButton(
                    name:
                    'hat bereits das Seepferdchen. Ziel ist es, sicherer zu schwimmen',
                    isChecked: false,
                  ),
                ],
              ),
            );
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: isSelected ? Colors.blue : Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon,
                size: 60.0, color: isSelected ? Colors.black : Colors.white),
            const SizedBox(height: 8.0),
            Text(buttonText,
                style:
                TextStyle(color: isSelected ? Colors.black : Colors.white)),
          ],
        ),
      ),
    );
  }
}

class SwimLevelRadioButtonClass extends StatelessWidget {
  const SwimLevelRadioButtonClass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
        builder: (context, state) {
          // Ersetzen der buildOptions Funktion, um eine ListView.separated zu verwenden
          Widget buildOptions(SwimLevelState state) {
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.swimLevelOptions.length,
              itemBuilder: (context, index) {
                final option = state.swimLevelOptions[index];
                if (state.swimLevelModel.value == SwimLevelEnum.EINSTEIGERKURS) {
                  return ListTile(
                    leading: Radio(
                      activeColor: Colors.lightBlueAccent,
                      groupValue: state.swimLevelRB.value,
                      value: option.name,
                      onChanged: (val) {
                        BlocProvider.of<SwimLevelBloc>(context).add(
                          SwimLevelRBChanged(
                            val.toString(),
                            option,
                          ),
                        );
                      },
                    ),
                    title: Text(option.name),
                  );
                } else if (state.swimLevelModel.value ==
                    SwimLevelEnum.AUFSTEIGERKURS) {
                  return ListTile(
                    leading: Checkbox(
                      value: option.isChecked,
                      onChanged: (bool? newValue) {
                        context.read<SwimLevelBloc>().add(
                          SwimLevelOptionCheckboxChanged(option, newValue!),
                        );
                      },
                    ),
                    title: Text(option.name),
                    onTap: () {
                      // Aktualisieren Sie den Wert, wenn auf das ListTile getippt wird
                      bool? newValue = !option.isChecked;
                      context.read<SwimLevelBloc>().add(
                        SwimLevelOptionCheckboxChanged(option, newValue),
                      );
                    },
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Für den Fall, dass keine Bedingung zutrifft
                }
              },
            );
          }

          return Visibility(
            visible: (state.swimLevelModel.value == SwimLevelEnum.EINSTEIGERKURS) ||
                (state.swimLevelModel.value == SwimLevelEnum.AUFSTEIGERKURS),
            child: Column(
              children: [
                // Keine Änderungen hier
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "",
                        style: TextStyle(
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
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 20.0),
                            child: Text(
                              'Schwimmschüler:in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        buildOptions(state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimLevelBloc, SwimLevelState>(
      listenWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context.read<SwimGeneratorCubit>().updateSwimLevel(
            state.swimLevelModel.value,
          );
        }
      },
      buildWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
        context.select((SwimLevelBloc bloc) => bloc.state.isValid);
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
              ? () => context.read<SwimLevelBloc>().add(FormSubmitted())
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
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
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
