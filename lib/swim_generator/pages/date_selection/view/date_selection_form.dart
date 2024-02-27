import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:swim_generator_app/swim_generator/cubit/swim_generator_cubit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../models/date_selection.dart';
import '../bloc/date_selection_bloc.dart';
import '../model/fix_date.dart';

class DateSelectionForm extends StatefulWidget {
  const DateSelectionForm({super.key});

  @override
  State<DateSelectionForm> createState() => _DateSelectionForm();
}

class _DateSelectionForm extends State<DateSelectionForm> {
  @override
  void initState() {
    super.initState();
    if (context.read<SwimGeneratorCubit>().state.dateSelection.flexFixDate) {
      BlocProvider.of<DateSelectionBloc>(context).add(SelectFixDate(
          bookingDateTypID: context
              .read<SwimGeneratorCubit>()
              .state
              .dateSelection
              .bookingDateTypID));
    } else {
      BlocProvider.of<DateSelectionBloc>(context).add(SelectFlexDate());
    }
    if (context.read<SwimGeneratorCubit>().state.dateSelection.isNotEmpty) {
      context.read<DateSelectionBloc>().add(FixDateChanged(
          context
              .read<SwimGeneratorCubit>()
              .state
              .dateSelection
              .fixDate
              .fixDateID,
          context.read<SwimGeneratorCubit>().state.dateSelection.fixDate));
    }
    final swimGeneratorCubit = context.read<SwimGeneratorCubit>();
    final swimCourseDateTypID =
        swimGeneratorCubit.state.swimCourseInfo.swimCourse.swimCourseDateTypID;
    final hasFixedDesiredDate = swimCourseDateTypID != 4;
    final swimCourseID =
        swimGeneratorCubit.state.swimCourseInfo.swimCourse.swimCourseID;
    final swimPoolIDs = swimGeneratorCubit.state.swimPools
        .map((pool) => pool.swimPoolID)
        .toList();

    context
        .read<DateSelectionBloc>()
        .add(UpdateHasFixedDesiredDate(hasFixedDesiredDate));
    context
        .read<DateSelectionBloc>()
        .add(LoadFixDates(swimCourseID, swimPoolIDs));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController desiredDateController1 =
        TextEditingController();
    final TextEditingController desiredTimeController1 =
        TextEditingController();
    final TextEditingController desiredDateController2 =
        TextEditingController();
    final TextEditingController desiredTimeController2 =
        TextEditingController();
    final TextEditingController desiredDateController3 =
        TextEditingController();
    final TextEditingController desiredTimeController3 =
        TextEditingController();
    return BlocListener<DateSelectionBloc, DateSelectionState>(
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
        children: [
          if (BlocProvider.of<SwimGeneratorCubit>(context)
              .state
              .configApp
              .isBooking) ...[
            _FlexFixDateSelected(),
            const SizedBox(
              height: 16,
            ),
            _FixDatesRadioButton(),
            const DesiredDateTimeText(),
            BirthDataInputMulti(
              dateController1: desiredDateController1,
              dateController2: desiredDateController2,
              dateController3: desiredDateController3,
            ),
            DesiredDateTimeInput(
              dateController: desiredDateController1,
              timeController: desiredTimeController1,
              title: 'Wunschtermin 1',
              onDateTimeSelected: (date, time) {
                context
                    .read<DateSelectionBloc>()
                    .add(UpdateDateTime1(date: date, time: time));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DesiredDateTimeInput(
              dateController: desiredDateController2,
              timeController: desiredTimeController2,
              title: 'Wunschtermin 2',
              onDateTimeSelected: (date, time) {
                context
                    .read<DateSelectionBloc>()
                    .add(UpdateDateTime2(date: date, time: time));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DesiredDateTimeInput(
              dateController: desiredDateController3,
              timeController: desiredTimeController3,
              title: 'Wunschtermin 3',
              onDateTimeSelected: (date, time) {
                context
                    .read<DateSelectionBloc>()
                    .add(UpdateDateTime3(date: date, time: time));
              },
            ),
            const SizedBox(
              height: 32,
            ),
          ] else ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Wir nehmen Deine Buchung als RESERVIERUNG entgegen.\n\n'
                  'Wir senden Dir zum 1.2 per Mail die Fixtermine zu. Sollten'
                  ' diese nicht in Euren Zeitplan passen hast du immer noch die '
                  'Möglichkeit per FLEX-Termine Kurze zu buchen'),
            ),
          ],
          const SizedBox(
            height: 32,
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

class _FlexFixDateSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesiredDate = context
            .read<SwimGeneratorCubit>()
            .state
            .swimCourseInfo
            .swimCourse
            .swimCourseDateTypID ==
        5;
    double xAlign;
    Color loginColor;
    Color signInColor;
    const double width = 300.0;
    const double height = 50.0;
    const double flexDateAlign = -1;
    const double fixDateAlign = 1;
    const Color selectedColor = Colors.white;
    const Color normalColor = Colors.black54;
    xAlign = flexDateAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
        builder: (context, state) {
      if (state.flexFixDate) {
        // FlexTermin ist ausgewählt
        xAlign = fixDateAlign; // fixDateAlign
        loginColor = Colors.black54;
        signInColor = Colors.white;
      } else {
        xAlign = flexDateAlign; // flexDateAlign
        loginColor = Colors.white;
        signInColor = Colors.black54;
      }
      return Visibility(
        visible:
            context.read<SwimGeneratorCubit>().state.configApp.isStartFixDate,
        child: Center(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: Alignment(xAlign, 0),
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: width * 0.5,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Color(0xFF009EE1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<DateSelectionBloc>(context)
                        .add(const FixDateChanged(0, FixDate.empty()));
                    BlocProvider.of<DateSelectionBloc>(context)
                        .add(SelectFlexDate());
                  },
                  child: Align(
                    alignment: const Alignment(-1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        'FLEXTERMIN',
                        style: TextStyle(
                          color: loginColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<DateSelectionBloc>(context).add(
                      SelectFixDate(
                        bookingDateTypID: isDesiredDate ? 3 : 2,
                      ),
                    );
                  },
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        isDesiredDate ? 'WUNSCHTERMIN' : 'FIXTERMIN',
                        style: TextStyle(
                          color: signInColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class DesiredDateTimeText extends StatelessWidget {
  const DesiredDateTimeText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
        builder: (context, state) {
      return Visibility(
        visible: (state.flexFixDate &&
                context
                        .read<SwimGeneratorCubit>()
                        .state
                        .swimCourseInfo
                        .swimCourse
                        .swimCourseDateTypID ==
                    5) ||
            context
                    .read<SwimGeneratorCubit>()
                    .state
                    .swimCourseInfo
                    .swimCourse
                    .swimCourseDateTypID ==
                2,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Wähle die Termine so dass wir uns min 2mal innerhalb "
                        "6 Tagen treffen. Viel effektiver wären 3 Termine. "
                        "Einmal die Woche macht keinen Sinn.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class BirthDataInputMulti extends StatefulWidget {
  final TextEditingController dateController1;
  final TextEditingController dateController2;
  final TextEditingController dateController3;

  const BirthDataInputMulti({
    super.key,
    required this.dateController1,
    required this.dateController2,
    required this.dateController3,
  });

  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}
class _BirthDataInputMulti extends State<MyCustomDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
      //buildWhen: (previous, current) => previous.birthDay != current.birthDay,
      builder: (context, state) {
        return Visibility(
          visible: (state.flexFixDate &&
                  context
                          .read<SwimGeneratorCubit>()
                          .state
                          .swimCourseInfo
                          .swimCourse
                          .swimCourseDateTypID ==
                      5) ||
              context
                      .read<SwimGeneratorCubit>()
                      .state
                      .swimCourseInfo
                      .swimCourse
                      .swimCourseDateTypID ==
                  2,
          child: ElevatedButton(
            key: const Key('personalInfoForm_birthDayInput_textField'),
            //controller: controller,
            onPressed: () async {
              // Starten Sie den Dialog und warten Sie auf das Ergebnis
              final List<DateTime>? selectedDates =
                  await showDialog<List<DateTime>>(
                context: context,
                builder: (BuildContext context) {
                  // Initialisieren Sie eine temporäre Liste für ausgewählte Daten innerhalb des Dialogs
                  List<DateTime> tempSelectedDates = [];
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text('Wählen Sie bis zu 3 Tage'),
                        content: SizedBox(
                          height: 300,
                          width: 300,
                          child: SfDateRangePicker(
                            showActionButtons: true,
                            cancelText: 'Abbrechen',
                            onSubmit: (Object? value) {
                              if (value is List<DateTime> &&
                                  value.length == 3) {
                                // Nur fortfahren, wenn genau 3 Tage ausgewählt sind
                                tempSelectedDates = value;
                                tempSelectedDates
                                    .sort((a, b) => a.compareTo(b));

                                // Zuweisung der ausgewählten Daten zu den Textfeldern
                                dateController1.text = DateFormat('dd.MM.yyyy')
                                    .format(tempSelectedDates[0]);
                                dateController2.text = DateFormat('dd.MM.yyyy')
                                    .format(tempSelectedDates[1]);
                                dateController3.text = DateFormat('dd.MM.yyyy')
                                    .format(tempSelectedDates[2]);

                                Navigator.of(context).pop(); // Dialog schließen
                                setState(() {});
                              } else {
                                // Anzeigen einer Benachrichtigung oder Aktualisierung des UI, um den Benutzer zu informieren
                              }
                            },
                            onCancel: () => Navigator.of(context).pop(),
                            selectionMode:
                                DateRangePickerSelectionMode.multiple,
                            initialSelectedDate: DateTime.now(),
                            enablePastDates: false,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Abbrechen'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: selectedDates.length == 3 ? () => _submitSelection() : null,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: Text(''),
          ),
        );
      },
    );
  }

}

class DesiredDateTimeInput extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  final String title;
  final Function(DateTime, TimeOfDay) onDateTimeSelected;

  const DesiredDateTimeInput({
    super.key,
    required this.dateController,
    required this.timeController,
    required this.title,
    required this.onDateTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
      builder: (context, state) {
        if (!state.flexFixDate) {
          dateController.text = '';
          timeController.text = '';
        }
        return Visibility(
          visible: (state.flexFixDate &&
                  context
                          .read<SwimGeneratorCubit>()
                          .state
                          .swimCourseInfo
                          .swimCourse
                          .swimCourseDateTypID ==
                      5) ||
              context
                      .read<SwimGeneratorCubit>()
                      .state
                      .swimCourseInfo
                      .swimCourse
                      .swimCourseDateTypID ==
                  2,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      const Text('*',
                          style: TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: IgnorePointer(
                        child: TextField(
                          controller: dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Datum',
                          ),
                        ),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: timeController,
                          readOnly: true,
                          onTap: () async {
                            await _selectTime(context);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Uhrzeit',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
      dateFormat: "dd.MMMM.yyyy",
      locale: DateTimePickerLocale.de,
      looping: false,
      pickerMode: DateTimePickerMode.date,
      //backgroundColor: Colors.lightBlueAccent,
      titleText: "Datum auswählen",
      itemTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );

    if (pickedDate != null) {
      final TimeOfDay? existingTime = _getTimeFromController();

      if (existingTime != null) {
        onDateTimeSelected(pickedDate, existingTime);
      }
      var formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      dateController.text = formattedDate;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Runden der Minuten auf den nächsten 30-Minuten-Takt
      final int roundedMinute = ((pickedTime.minute + 15) ~/ 30 * 30) % 60;
      final int additionalHour = ((pickedTime.minute + 15) ~/ 30 * 30) ~/ 60;
      final TimeOfDay adjustedTime = TimeOfDay(
          hour: (pickedTime.hour + additionalHour) % 24, minute: roundedMinute);

      final DateTime? existingDate = _getDateFromController();
      if (existingDate != null) {
        // Verwenden Sie `adjustedTime` statt `pickedTime`
        onDateTimeSelected(existingDate, adjustedTime);
      }

      // Formatieren und setzen des Textes mit der angepassten Zeit
      var formattedTime = _formatTimeOfDay(adjustedTime);
      timeController.text = formattedTime;
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }

  TimeOfDay? _getTimeFromController() {
    try {
      final timeString = timeController.text;
      if (timeString.isEmpty) return null;

      final timeParts = timeString.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }

  DateTime? _getDateFromController() {
    try {
      final dateString = dateController.text;
      if (dateString.isEmpty) return null;

      // Erstellen Sie ein DateFormat, das mit dem Format übereinstimmt, das Sie verwenden
      final format = DateFormat('dd.MM.yyyy');
      return format.parse(dateString);
    } catch (e) {
      // Im Fehlerfall oder wenn das Datum nicht geparst werden kann, geben Sie null zurück
      return null;
    }
  }
}

class _FixDatesRadioButton extends StatelessWidget {
  Widget buildDateText(
      BuildContext context, DateSelectionState state, int index) {
    final fixDateFrom =
        DateFormat('dd.MM').format(state.fixDates[index].fixDateFrom!);
    final fixDateTo =
        DateFormat('dd.MM').format(state.fixDates[index].fixDateTo!);
    final fixDateTimeFrom =
        DateFormat('HH:mm').format(DateTime(2024, 1, 1, 12, 30));
    final fixDateTimeTo =
        DateFormat('HH:mm').format(DateTime(2024, 1, 1, 13, 30));
    final swimPoolIndex = context
        .read<SwimGeneratorCubit>()
        .state
        .swimPools
        .indexWhere((element) =>
            element.swimPoolID == state.fixDates[index].swimPoolID);

    String swimPoolName;
    if (swimPoolIndex != -1) {
      swimPoolName = context
          .read<SwimGeneratorCubit>()
          .state
          .swimPools[swimPoolIndex]
          .swimPoolName
          .split(',')[1];
    } else {
      swimPoolName = "Unbekanntes Schwimmbad";
    }

    return Text(
      '$fixDateFrom - $fixDateTo UM $fixDateTimeFrom - $fixDateTimeTo $swimPoolName',
      overflow: TextOverflow.visible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
        builder: (context, state) {
      return !state.loadingFixDates.isSuccess
          ? const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            )
          : Column(
              children: [
                Visibility(
                  visible: state.hasFixedDesiredDate &&
                      ((state.flexFixDate &&
                              context
                                      .read<SwimGeneratorCubit>()
                                      .state
                                      .swimCourseInfo
                                      .swimCourse
                                      .swimCourseDateTypID ==
                                  1) ||
                          context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .swimCourseInfo
                                  .swimCourse
                                  .swimCourseDateTypID ==
                              3),
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Passenden Termin auswählen',
                                style: TextStyle(fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                              ),
                              Text('*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          ListView.separated(
                            separatorBuilder: (_, __) =>
                                Divider(color: Colors.grey[300]),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.fixDates.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                // height: 50,
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.lightBlueAccent,
                                      groupValue: state.fixDateModel.value,
                                      value: state.fixDates[index].fixDateID,
                                      onChanged: (val) {
                                        BlocProvider.of<DateSelectionBloc>(
                                                context)
                                            .add(FixDateChanged(
                                                val!, state.fixDates[index]));
                                      },
                                    ),
                                    Flexible(
                                      child: Wrap(
                                        children: [
                                          buildDateText(context, state, index),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!state.flexFixDate) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Wir nehmen Deine Buchung als RESERVIERUNG entgegen.\n\n'
                        'Am 1.3. laden wir Dich per Email ein uns DEINE '
                        'VERFÜGBAREN Termine für den Schwimmsommer den Du '
                        'gebucht hast zu nennen.\n\n'
                        'WIR PLANEN euren Schwimmkurs nach DEINER '
                        'INDIVIDUELLEN VERFÜGBARKEIT.'),
                  ),
                ],
              ],
            );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DateSelectionBloc, DateSelectionState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context.read<SwimGeneratorCubit>().updateDateSelection(DateSelection(
                fixDate: state.selectedFixDate,
                flexFixDate: state.flexFixDate,
                bookingDateTypID: state.bookingDateTypID,
                dateTimes: state.bookingDateTypID == 3
                    ? [state.dateTime1!, state.dateTime2!, state.dateTime3!]
                    : [],
              ));
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid = context
                    .read<SwimGeneratorCubit>()
                    .state
                    .swimCourseInfo
                    .swimCourse
                    .swimCourseDateTypID ==
                4
            ? true
            : context.select((DateSelectionBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
                color: Colors.lightBlueAccent,
                size: 50.0,
              )
            : ElevatedButton(
                key: const Key('swimCourseForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.lightBlueAccent),
                onPressed: isValid
                    ? () =>
                        context.read<DateSelectionBloc>().add(FormSubmitted())
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
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
        buildWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
                  key: const Key('swimCourseForm_cancelButton_elevatedButton'),
                  onPressed: () =>
                      context.read<SwimGeneratorCubit>().stepCancelled(),
                  child: const Text('Zurück'),
                );
        });
  }
}
