import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_school/bloc/swim_school_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../swim_generator.dart';

class SwimSchoolForm extends StatefulWidget {
  const SwimSchoolForm({super.key});

  @override
  State<SwimSchoolForm> createState() => _SwimSchoolForm();
}

class _SwimSchoolForm extends State<SwimSchoolForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimSchoolBloc>().add(LoadSwimSchools());

    if (context.read<SwimGeneratorCubit>().state.swimSchool.swimSchoolName !=
        '') {
      BlocProvider.of<SwimSchoolBloc>(context).add(SelectSwimSchool(
        context.read<SwimGeneratorCubit>().state.swimSchool,
        context.read<SwimGeneratorCubit>().state.swimSchool.swimSchoolName,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimSchoolBloc, SwimSchoolState>(
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
          //const SwimSchoolDropDown(),
          const SwimSchoolRadioButtons(),
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
}

// class SwimSchoolDropDown extends StatelessWidget {
//   const SwimSchoolDropDown({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SwimSchoolBloc, SwimSchoolState>(
//       builder: (context, state) {
//         return InputDecorator(
//           decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
//             labelText: 'Bitte Schwimmschule auswählen',
//             border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: !state.loadingSwimSchoolStatus.isSuccess
//                 ? const SpinKitWaveSpinner(
//                     color: Colors.lightBlueAccent,
//                     size: 50.0,
//                   )
//                 : DropdownButton<SwimSchool>(
//                     isExpanded: true,
//                     value: state.swimSchoolSelected.value,
//                     items: state.availableSchools.map((SwimSchool school) {
//                       return DropdownMenuItem<SwimSchool>(
//                         value: school,
//                         child: Text(school.swimSchoolName),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       BlocProvider.of<SwimSchoolBloc>(context).add(
//                           SelectSwimSchool(value!, value.swimSchoolName,
//                               value.swimSchoolID));
//                     },
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }

class SwimSchoolRadioButtons extends StatelessWidget {
  const SwimSchoolRadioButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimSchoolBloc, SwimSchoolState>(
        builder: (context, state) {
      return Card(
        elevation: 4.0,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              labelText: 'Bitte Schwimmschule auswählen',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
            ),
            child: !state.loadingSwimSchoolStatus.isSuccess
                ? const SpinKitWaveSpinner(
                    color: Colors.lightBlueAccent,
                    size: 50.0,
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      ListView.separated(
                        separatorBuilder: (_, __) =>
                            Divider(color: Colors.grey[300]),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.availableSchools.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<SwimSchoolBloc>(context).add(
                                SelectSwimSchool(
                                  state.availableSchools[index],
                                  state.availableSchools[index].swimSchoolName,
                                ),
                              );
                            },
                            child: SizedBox(
                              // height: 50,
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.lightBlueAccent,
                                    groupValue: state.swimSchoolSelected.value,
                                    value: state
                                        .availableSchools[index].swimSchoolName,
                                    onChanged: (value) {
                                      BlocProvider.of<SwimSchoolBloc>(context)
                                          .add(
                                        SelectSwimSchool(
                                          state.availableSchools[index],
                                          value.toString(),
                                        ),
                                      );
                                    },
                                  ),
                                  Flexible(
                                    child: Wrap(
                                      children: [
                                        Text(
                                          '${state.availableSchools[index].swimSchoolName} ',
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
      );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimSchoolBloc, SwimSchoolState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context.read<SwimGeneratorCubit>().updateSwimSchool(state.swimSchool);
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
            context.select((SwimSchoolBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
                color: Colors.lightBlueAccent,
                size: 50.0,
              )
            : ElevatedButton(
                key: const Key(
                    'ParentPersonalInfoForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.lightBlueAccent),
                onPressed: isValid
                    ? () => context.read<SwimSchoolBloc>().add(FormSubmitted())
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
    return BlocConsumer<SwimSchoolBloc, SwimSchoolState>(
      listenWhen: (previous, current) =>
          previous.cancellationStatus != current.cancellationStatus,
      listener: (context, state) {
        if (state.cancellationStatus.isSuccess) {
          Navigator.of(context).pop(true);
          _launchUrl(state.swimSchoolUrl.isNotEmpty
              ? state.swimSchoolUrl
              : "https://wassermenschen.org/");
        }
      },
      buildWhen: (previous, current) =>
          previous.cancellationStatus != current.cancellationStatus,
      builder: (context, state) {
        context.select((SwimSchoolBloc bloc) => bloc.state.isValid);
        return state.cancellationStatus.isInProgress
            ? const SpinKitWaveSpinner(
                color: Colors.lightBlueAccent,
                size: 50.0,
              )
            : TextButton(
                key: const Key(
                    'ParentPersonalInfoForm_cancelButton_elevatedButton'),
                onPressed: () {
                  context.read<SwimSchoolBloc>().add(FormCancelled());
                },
                child: const Text('Abrechen'),
              );
      },
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
