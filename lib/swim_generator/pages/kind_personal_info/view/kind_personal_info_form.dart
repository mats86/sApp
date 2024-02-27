import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/models/kind_personal_info.dart';
import '../../../cubit/swim_generator_cubit.dart';

import '../bloc/kind_personal_info_bloc.dart';

class KindPersonalInfoForm extends StatefulWidget {
  const KindPersonalInfoForm({super.key});

  @override
  State<KindPersonalInfoForm> createState() => _KindPersonalInfoForm();
}

class _KindPersonalInfoForm extends State<KindPersonalInfoForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _firstNameFocusNod = FocusNode();
  final FocusNode _lastNameFocusNod = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstNameController.text =
        context.read<SwimGeneratorCubit>().state.kindPersonalInfo.firstName;
    _lastNameController.text =
        context.read<SwimGeneratorCubit>().state.kindPersonalInfo.lastName;
    if (context.read<SwimGeneratorCubit>().state.kindPersonalInfo.firstName !=
        '') {
      context.read<KindPersonalInfoBloc>().add(FirstNameChanged(
          context.read<SwimGeneratorCubit>().state.kindPersonalInfo.firstName));
    }
    if (context.read<SwimGeneratorCubit>().state.kindPersonalInfo.lastName !=
        '') {
      context.read<KindPersonalInfoBloc>().add(LastNameChanged(
          context.read<SwimGeneratorCubit>().state.kindPersonalInfo.lastName));
    }

    _firstNameFocusNod.addListener(() {
      if (!_firstNameFocusNod.hasFocus) {
        context.read<KindPersonalInfoBloc>().add(FirstNameUnfocused());
        FocusScope.of(context).requestFocus(_lastNameFocusNod);
      }
    });
    _lastNameFocusNod.addListener(() {
      if (!_lastNameFocusNod.hasFocus) {
        context.read<KindPersonalInfoBloc>().add(LastNameUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNod.dispose();
    _lastNameFocusNod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KindPersonalInfoBloc, KindPersonalInfoState>(
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
          _FirstNameInput(
            controller: _firstNameController,
            focusNode: _firstNameFocusNod,
          ),
          _LastNameInput(
            controller: _lastNameController,
            focusNode: _lastNameFocusNod,
          ),
          const SizedBox(
            height: 32.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Entwicklungsstatus des Schwimmschülers',
                    style: TextStyle(
                      fontSize: 16, // Ihre Textgröße// Farbe des Textes
                    ),
                  ),
                  TextSpan(
                    text: ' *', // Sternchen direkt nach dem Text
                    style: TextStyle(
                      color: Colors.red, // Farbe des Sternchens
                      fontSize: 16, // Größe des Sternchens
                    ),
                  ),
                ],
              ),
              overflow:
              TextOverflow.visible, // Einstellung für den Textüberlauf
            ),
          ),
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _buildCheckboxRow(
                    context,
                    'Körperliche Entwicklungsverzögerungen',
                        (state) => state.isPhysicalDelay.value,
                        (val) => context
                        .read<KindPersonalInfoBloc>()
                        .add(PhysicalDelayChanged(val!)),
                  ),
                  const Divider(),
                  _buildCheckboxRow(
                    context,
                    'Geistige Entwicklungsverzögerungen',
                        (state) => state.isMentalDelay.value,
                        (val) => context
                        .read<KindPersonalInfoBloc>()
                        .add(MentalDelayChanged(val!)),
                  ),
                  const Divider(),
                  _buildCheckboxRow(
                    context,
                    'Keine Einschränkungen',
                        (state) => state.isNoLimit.value,
                        (val) => context
                        .read<KindPersonalInfoBloc>()
                        .add(NoLimitsChanged(val!)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _BackButton()),
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

  Widget _buildCheckboxRow(
      BuildContext context,
      String label,
      bool Function(KindPersonalInfoState) valueGetter,
      Function(bool?) onChanged,
      ) {
    return Row(
      children: <Widget>[
        BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
          builder: (context, state) {
            return Checkbox(
              activeColor: Colors.lightBlueAccent,
              value: valueGetter(state),
              onChanged: onChanged,
            );
          },
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _FirstNameInput({
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          key: const Key('KindPersonalInfoForm_firstNameInput_textField'),
          onChanged: (firstName) => context
              .read<KindPersonalInfoBloc>()
              .add(FirstNameChanged(firstName)),
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'Vorname des Schwimmschülers',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*', style: TextStyle(color: Colors.red, fontSize: 14)),
                ],
              ),
            ),
            errorText: state.firstName.displayError != null
                ? state.firstName.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _LastNameInput({
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) => previous.lastName != current.lastName,
        builder: (context, state) {
          return TextField(
            focusNode: focusNode,
            key: const Key('KindPersonalInfoForm_lastNameInput_textField'),
            onChanged: (lastName) => context
                .read<KindPersonalInfoBloc>()
                .add(LastNameChanged(lastName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Nachname des Schwimmschülers',
                      style: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
              ),
              errorText: state.lastName.displayError != null
                  ? state.lastName.error?.message
                  : null,
            ),
            controller: controller,
          );
        });
  }
}

// class _BuildCheckboxWithText extends StatelessWidget {
//   final String text;
//   final bool isChecked;
//   final Function(bool?) onCheckboxChanged;
//
//   const _BuildCheckboxWithText({
//     required this.text,
//     required this.isChecked,
//     required this.onCheckboxChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         children: <Widget>[
//           BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
//             builder: (context, state) {
//               print('fun');
//               print(isChecked);
//               return Checkbox(
//                 activeColor: Colors.lightBlueAccent,
//                 value: isChecked,
//                 onChanged: onCheckboxChanged,
//               );
//             },
//           ),
//           Expanded(
//             child: Text(text),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindPersonalInfoBloc, KindPersonalInfoState>(
      listenWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context
              .read<SwimGeneratorCubit>()
              .updateKindPersonalInfo(KindPersonalInfo(
            firstName: state.firstName.value.trim(),
            lastName: state.lastName.value.trim(),
            kidsDevelopState: state.kidsDevelopState,
          ));
        }
      },
      buildWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
        context.select((KindPersonalInfoBloc bloc) => bloc.state.isValid);
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
              ? () => context
              .read<KindPersonalInfoBloc>()
              .add(FormSubmitted())
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

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
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
            child: const Text('Zurück'),
          );
        });
  }
}
