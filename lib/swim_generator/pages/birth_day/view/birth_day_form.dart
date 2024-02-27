import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../../../models/swim_course_info.dart';
import '../bloc/birth_day_bloc.dart';

class BirthDayForm extends StatefulWidget {
  const BirthDayForm({
    super.key,
    required this.swimCourseID,
  });

  final int swimCourseID;

  @override
  State<BirthDayForm> createState() => _BirthDayForm();
}

class _BirthDayForm extends State<BirthDayForm> {
  final TextEditingController _birthDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (context.read<SwimGeneratorCubit>().state.birthDay.birthDay != null) {
      _birthDayController.text = DateFormat('dd.MM.yyyy')
          .format(context.read<SwimGeneratorCubit>().state.birthDay.birthDay!);
      context.read<BirthDayBloc>().add(BirthDayChanged(
          context.read<SwimGeneratorCubit>().state.birthDay.birthDay!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BirthDayBloc, BirthDayState>(
      listener: (context, state) {
        if (state.birthDay.value != null) {
          _birthDayController.text =
              DateFormat('dd.MM.yyyy').format(state.birthDay.value!);
        }
        if (state.submissionStatus.isFailure) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              double width = MediaQuery.of(context).size.width;
              return AlertDialog(
                title: const Row(
                  children: <Widget>[
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(child: Text('Problem mit der Kursbuchung')),
                  ],
                ),
                content: SizedBox(
                  width: width < 400.0 ? width * 0.9 : 400,
                  child: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                            'Die von Ihnen eingegebenen Informationen passen nicht zu dem von Ihnen ausgewählten Kurs.'),
                        Text(
                            'Möchten Sie alternative Kurse, die besser zu Ihrem Profil passen, anzeigen lassen?'),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Alternativen ansehen'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  TextButton(
                    child: const Text('Zurück zur Hauptseite'),
                    onPressed: () {
                      context.read<BirthDayBloc>().add(CancelAlert());
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // BirthDataInputNew(
          //   controller: _birthDayController,
          // ),
          BirthDataInputNewTip(
            controller: _birthDayController,
          ),
          const SizedBox(
            height: 16.0,
          ),
          // _SwimCourseRadioButton(),
          const SizedBox(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: _SubmitButton(
                swimCourseID: widget.swimCourseID,
                isDirectLinks: context
                    .read<SwimGeneratorCubit>()
                    .state
                    .configApp
                    .isDirectLinks,
              ))
            ],
          )
        ],
      ),
    );
  }
}

// class _BirthDataInput extends StatelessWidget {
//   final TextEditingController controller;
//
//   const _BirthDataInput({
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BirthDayBloc, BirthDayState>(
//       buildWhen: (previous, current) => previous.birthDay != current.birthDay,
//       builder: (context, state) {
//         return TextFormField(
//           key: const Key('personalInfoForm_birthDayInput_textField'),
//           // onChanged: (birthday) => context
//           //     .read<BirthDayBloc>()
//           //     .add(BirthDayChanged(birthday)),
//           controller: controller,
//           readOnly: true,
//           onTap: () async {
//             var datePicked = await DatePicker.showSimpleDatePicker(context,
//                 lastDate: DateTime.now(),
//                 initialDate: context
//                     .read<SwimGeneratorCubit>()
//                     .state
//                     .birthDay
//                     .birthDay ??
//                     DateTime(2020),
//                 dateFormat: "dd.MMMM.yyyy",
//                 locale: DateTimePickerLocale.de,
//                 looping: false,
//                 pickerMode: DateTimePickerMode.date,
//                 //backgroundColor: Colors.lightBlueAccent,
//                 titleText: "Datum auswählen",
//                 itemTextStyle: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//                 backgroundColor: Theme.of(context).colorScheme.background);
//             controller.text = DateFormat('dd.MM.yyyy').format(datePicked!);
//             if (context.mounted) {
//               context.read<BirthDayBloc>().add(BirthDayChanged(datePicked));
//             }
//             //Navigator.push(
//             //    context, MaterialPageRoute(builder: (_) => WidgetPage()));
//           },
//           keyboardType: TextInputType.datetime,
//           decoration: InputDecoration(
//             label: const FittedBox(
//               fit: BoxFit.fitWidth,
//               child: Row(
//                 children: [
//                   Text(
//                     'Geburtstag des Kindes',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(3.0),
//                   ),
//                   Text(
//                     '*',
//                     style: TextStyle(color: Colors.red, fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             errorText:
//             state.birthDay.isValid ? state.birthDay.error?.message : null,
//           ),
//         );
//       },
//     );
//   }
// }

class BirthDataInputNew extends StatelessWidget {
  final TextEditingController controller;

  const BirthDataInputNew({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthDayBloc, BirthDayState>(
      buildWhen: (previous, current) => previous.birthDay != current.birthDay,
      builder: (context, state) {
        return TextFormField(
          key: const Key('personalInfoForm_birthDayInput_textField'),
          controller: controller,
          readOnly: true,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text('Wähle ein Geburtstagsdatum aus'),
                  content: SizedBox(
                    height: 300,
                    width: 300,
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      selectionColor: Colors.lightBlueAccent,
                      initialSelectedDate: DateTime.now(),
                      maxDate: DateTime.now(),
                      initialDisplayDate: DateTime(DateTime.now().year - 4),
                      showActionButtons: true,
                      cancelText: 'Abrechen',
                      onSubmit: (Object? value) {
                        Navigator.of(dialogContext).pop();
                        if (value is DateTime) {
                          controller.text =
                              DateFormat('dd.MM.yyyy').format(value);
                          context
                              .read<BirthDayBloc>()
                              .add(BirthDayChanged(value));
                        }
                      },
                      onCancel: () => Navigator.of(dialogContext).pop(),
                    ),
                  ),
                );
              },
            );
          },
          decoration: InputDecoration(
            labelText: 'Geburtstag des Schwimmschülers *',
            labelStyle: const TextStyle(fontSize: 14),
            errorText:
                state.birthDay.isValid ? null : state.birthDay.error?.message,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        );
      },
    );
  }
}

class BirthDataInputNewTip extends StatelessWidget {
  final TextEditingController controller;

  const BirthDataInputNewTip({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthDayBloc, BirthDayState>(
      buildWhen: (previous, current) => previous.birthDay != current.birthDay,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  final RegExp dateFormat =
                      RegExp(r'^[0-3][0-9]\.[0-1][0-9]\.[0-9]{4}$');
                  if (dateFormat.hasMatch(value)) {
                    context.read<BirthDayBloc>().add(
                        BirthDayChanged(DateFormat('dd.MM.yyyy').parse(value)));
                  }
                },
                key: const Key('personalInfoForm_birthDayInput_textField'),
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _DateInputFormatter(),
                ],
                decoration: InputDecoration(
                  label: const FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        Text(
                          'Geburtstag des Schwimmschülers',
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
                  errorText: state.birthDay.displayError != null
                      ? state.birthDay.error?.message
                      : null,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Wähle ein Geburtstagsdatum aus'),
                      content: SizedBox(
                        height: 300,
                        width: 300,
                        child: SfDateRangePicker(
                          selectionMode: DateRangePickerSelectionMode.single,
                          selectionColor: Colors.lightBlueAccent,
                          initialSelectedDate: DateTime.now(),
                          maxDate: DateTime.now(),
                          initialDisplayDate: DateTime(
                            DateTime.now().year - 1,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                          showActionButtons: true,
                          cancelText: 'Abrechen',
                          onSubmit: (Object? value) {
                            Navigator.of(dialogContext).pop();
                            if (value is DateTime) {
                              controller.text =
                                  DateFormat('dd.MM.yyyy').format(value);
                              context
                                  .read<BirthDayBloc>()
                                  .add(BirthDayChanged(value));
                            }
                          },
                          onCancel: () => Navigator.of(dialogContext).pop(),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.calendar_today,
                size: 30,
              ),
            )
          ],
        );
      },
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    final int oldTextLength = oldValue.text.length;

    if (newTextLength > oldTextLength) {
      if (newTextLength == 2 || newTextLength == 5) {
        return TextEditingValue(
          text: '${newValue.text}.',
          selection: newValue.selection.copyWith(
            baseOffset: newValue.selection.baseOffset + 1,
            extentOffset: newValue.selection.extentOffset + 1,
          ),
        );
      }
    }

    return newValue;
  }
}

class _SubmitButton extends StatelessWidget {
  final int swimCourseID;
  final bool isDirectLinks;

  const _SubmitButton({
    required this.swimCourseID,
    required this.isDirectLinks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BirthDayBloc, BirthDayState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context
              .read<SwimGeneratorCubit>()
              .updateBirthDay(state.birthDay.value);
          //---------------//

          SwimCourseInfo swimCourseInfo = SwimCourseInfo(
              season: '',
              swimCourse: BlocProvider.of<BirthDayBloc>(context)
                  .state
                  .autoSelectedCourse);
          context
              .read<SwimGeneratorCubit>()
              .updateSwimCourseInfo(swimCourseInfo);
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
            context.select((BirthDayBloc bloc) => bloc.state.isValid);
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
                    ? () => context.read<BirthDayBloc>().add(FormSubmitted(
                          swimCourseID,
                          isDirectLinks,
                        ))
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
    return BlocBuilder<BirthDayBloc, BirthDayState>(
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
