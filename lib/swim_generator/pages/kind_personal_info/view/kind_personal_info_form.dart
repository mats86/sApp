import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../cubit/swim_generator_cubit.dart';

import '../../../models/swim_course_info.dart';
import '../../../models/swim_pool_info.dart';
import '../bloc/kind_personal_info_bloc.dart';

class KindPersonalInfoForm extends StatefulWidget {
  const KindPersonalInfoForm({
    super.key,
  });

  @override
  State<KindPersonalInfoForm> createState() => _KindPersonalInfoForm();
}

class _KindPersonalInfoForm extends State<KindPersonalInfoForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _customerInvitedFirstNameController =
      TextEditingController();
  final TextEditingController _customerInvitedLastNameController =
      TextEditingController();
  final TextEditingController _customerInvitedEmailController =
      TextEditingController();
  final TextEditingController _customerInvitedPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (context.read<SwimGeneratorCubit>().state.configApp.isCodeLinks) {
      context.read<KindPersonalInfoBloc>().add(LoadSwimBookingByCode(
          swimBookingCode:
              context.read<SwimGeneratorCubit>().state.configApp.code));
      context.read<SwimGeneratorCubit>().updateConfigApp(
            isBooking: true,
          );
    }
    final currentChildInfo = context
        .read<SwimGeneratorCubit>()
        .state
        .kindPersonalInfo
        .childInfos[context.read<SwimGeneratorCubit>().state.childInfoIndex];

    _firstNameController.text = currentChildInfo.firstName.value;
    _lastNameController.text = currentChildInfo.lastName.value;
    if (currentChildInfo.firstName.value != '') {
      context.read<KindPersonalInfoBloc>().add(FirstNameChanged(
            firstName: currentChildInfo.firstName.value,
          ));
    }
    if (currentChildInfo.lastName.value != '') {
      context.read<KindPersonalInfoBloc>().add(LastNameChanged(
            lastName: currentChildInfo.lastName.value,
          ));
    }

    if (context.read<SwimGeneratorCubit>().state.childInfoIndex == 0 &&
        !context.read<SwimGeneratorCubit>().state.configApp.isCodeLinks) {
      context.read<KindPersonalInfoBloc>().add(BirthDayChanged(
          birthDay:
              context.read<SwimGeneratorCubit>().state.birthDay.birthDay!));
    } else if (currentChildInfo.birthDay.value != null) {
      _birthDayController.text =
          DateFormat('dd.MM.yyyy').format(currentChildInfo.birthDay.value!);
      context
          .read<KindPersonalInfoBloc>()
          .add(BirthDayChanged(birthDay: currentChildInfo.birthDay.value!));
    }
    if (currentChildInfo.isPhysicalDelay.value) {
      context.read<KindPersonalInfoBloc>().add(PhysicalDelayChanged(
          isChecked: currentChildInfo.isPhysicalDelay.value));
    }

    if (currentChildInfo.isMentalDelay.value) {
      context.read<KindPersonalInfoBloc>().add(
          MentalDelayChanged(isChecked: currentChildInfo.isMentalDelay.value));
    }

    if (currentChildInfo.isNoLimit.value) {
      context
          .read<KindPersonalInfoBloc>()
          .add(NoLimitsChanged(isChecked: currentChildInfo.isNoLimit.value));
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDayController.dispose();
    _customerInvitedFirstNameController.dispose();
    _customerInvitedLastNameController.dispose();
    _customerInvitedEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outerContext = context;
    return BlocListener<KindPersonalInfoBloc, KindPersonalInfoState>(
      listener: (context, state) {
        if (state.submissionStatus.isFailure) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              double width = MediaQuery.of(context).size.width;
              return AlertDialog(
                title: const Text('Eingegebene Alter passt nicht'),
                content: SizedBox(
                  width: width < 400.0 ? width * 0.9 : 400,
                  child: const Text('DAS PASST LEIDER NICHT. - '
                      'Am schnellsten lernt es sich wenn Kinder in einer '
                      'Gruppe möglichst den gleichen Entwicklungsstand '
                      'aufweisen. So wird niemand unter- aber auch nicht '
                      'überfordert. Aus diesen Gründen können wir das Kind '
                      'nicht in diese Gruppe aufnehmen. Andere '
                      'Möglichkeiten bieten unsere 3-Freundeskurse. '
                      'Hier spielen soziale Faktoren die entscheidende Rolle. '),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      outerContext
                          .read<KindPersonalInfoBloc>()
                          .add(CloseAlertDialog());
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (context.read<SwimGeneratorCubit>().state.childInfoIndex >
                0) ...[
              _ChildFriendSelected(
                firstNameChildController: _firstNameController,
                lastNameChildController: _lastNameController,
                birthDayChildController: _birthDayController,
                firstNameGuardianController:
                    _customerInvitedFirstNameController,
                lastNameGuardianController: _customerInvitedLastNameController,
                emailGuardianController: _customerInvitedEmailController,
                phoneNumberGuardianController:
                    _customerInvitedPhoneNumberController,
              ),
              const SizedBox(
                height: 32.0,
              ),
            ],
            if (!context
                .read<SwimGeneratorCubit>()
                .state
                .swimCourseInfo
                .swimCourse
                .isAdultCourse) ...[
              if (!context
                  .read<KindPersonalInfoBloc>()
                  .state
                  .childFriendSelected) ...[
                _FirstNameInput(
                  controller: _firstNameController,
                ),
                _LastNameInput(
                  controller: _lastNameController,
                ),
                if (context.read<SwimGeneratorCubit>().state.childInfoIndex >
                        0 ||
                    context
                        .read<SwimGeneratorCubit>()
                        .state
                        .configApp
                        .isCodeLinks) ...[
                  BirthDataInputNewTip(
                    key: UniqueKey(),
                    controller: _birthDayController,
                  ),
                ],
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
                          (state) => state.childInfo.isPhysicalDelay.value,
                          (val) => context
                              .read<KindPersonalInfoBloc>()
                              .add(PhysicalDelayChanged(isChecked: val!)),
                        ),
                        const Divider(),
                        _buildCheckboxRow(
                          context,
                          'Geistige Entwicklungsverzögerungen',
                          (state) => state.childInfo.isMentalDelay.value,
                          (val) => context
                              .read<KindPersonalInfoBloc>()
                              .add(MentalDelayChanged(isChecked: val!)),
                        ),
                        const Divider(),
                        _buildCheckboxRow(
                          context,
                          'Keine Einschränkungen',
                          (state) => state.childInfo.isNoLimit.value,
                          (val) => context
                              .read<KindPersonalInfoBloc>()
                              .add(NoLimitsChanged(isChecked: val!)),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                _CustomerInvitedFirstNameInput(
                  controller: _customerInvitedFirstNameController,
                ),
                _CustomerInvitedLastNameInput(
                  controller: _customerInvitedLastNameController,
                ),
                _CustomerInvitedEmailInput(
                  controller: _customerInvitedEmailController,
                ),
                _CustomerInvitedPhoneNumberInputFlag(
                    controller: _customerInvitedPhoneNumberController),
              ],
            ] else ...[
              _CustomerInvitedFirstNameInput(
                controller: _customerInvitedFirstNameController,
              ),
              _CustomerInvitedLastNameInput(
                controller: _customerInvitedLastNameController,
              ),
              _CustomerInvitedEmailInput(
                controller: _customerInvitedEmailController,
              ),
              _CustomerInvitedPhoneNumberInputFlag(
                  controller: _customerInvitedPhoneNumberController),
            ],
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
        );
      }),
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

class _ChildFriendSelected extends StatelessWidget {
  final TextEditingController firstNameChildController;
  final TextEditingController lastNameChildController;
  final TextEditingController birthDayChildController;
  final TextEditingController firstNameGuardianController;
  final TextEditingController lastNameGuardianController;
  final TextEditingController emailGuardianController;
  final TextEditingController phoneNumberGuardianController;

  const _ChildFriendSelected({
    required this.firstNameChildController,
    required this.lastNameChildController,
    required this.birthDayChildController,
    required this.firstNameGuardianController,
    required this.lastNameGuardianController,
    required this.emailGuardianController,
    required this.phoneNumberGuardianController,
  });

  @override
  Widget build(BuildContext context) {
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
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        builder: (context, state) {
      if (state.childFriendSelected) {
        // FlexTermin ist ausgewählt
        xAlign = fixDateAlign; // fixDateAlign
        loginColor = Colors.black54;
        signInColor = Colors.white;
      } else {
        xAlign = flexDateAlign; // flexDateAlign
        loginColor = Colors.white;
        signInColor = Colors.black54;
      }
      return Center(
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
                  firstNameChildController.text = '';
                  lastNameChildController.text = '';
                  birthDayChildController.text = '';
                  BlocProvider.of<KindPersonalInfoBloc>(context)
                      .add(const PhysicalDelayChanged(isChecked: false));
                  BlocProvider.of<KindPersonalInfoBloc>(context)
                      .add(const MentalDelayChanged(isChecked: false));
                  BlocProvider.of<KindPersonalInfoBloc>(context)
                      .add(const NoLimitsChanged(isChecked: false));
                  BlocProvider.of<KindPersonalInfoBloc>(context)
                      .add(SelectChild());
                },
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'KIND',
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
                  firstNameGuardianController.text = '';
                  lastNameGuardianController.text = '';
                  emailGuardianController.text = '';
                  phoneNumberGuardianController.text = '';
                  BlocProvider.of<KindPersonalInfoBloc>(context).add(
                    const SelectFriend(),
                  );
                },
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'FREUND',
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
      );
    });
  }
}

class _FirstNameInput extends StatelessWidget {
  final TextEditingController controller;

  const _FirstNameInput({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.childInfo.firstName != current.childInfo.firstName,
      builder: (context, state) {
        return TextField(
          controller: controller,
          onChanged: (firstName) =>
              context.read<KindPersonalInfoBloc>().add(FirstNameChanged(
                    firstName: firstName,
                  )),
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
            errorText: state.childInfo.firstName.displayError != null
                ? state.childInfo.firstName.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  final TextEditingController controller;

  const _LastNameInput({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.childInfo.lastName != current.childInfo.lastName,
        builder: (context, state) {
          return TextField(
            onChanged: (lastName) =>
                context.read<KindPersonalInfoBloc>().add(LastNameChanged(
                      lastName: lastName,
                    )),
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
              errorText: state.childInfo.lastName.displayError != null
                  ? state.childInfo.lastName.error?.message
                  : null,
            ),
            controller: controller,
          );
        });
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
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.childInfo.birthDay != current.childInfo.birthDay,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  final RegExp dateFormat =
                      RegExp(r'^[0-3][0-9]\.[0-1][0-9]\.[0-9]{4}$');
                  if (dateFormat.hasMatch(value)) {
                    context.read<KindPersonalInfoBloc>().add(BirthDayChanged(
                        birthDay: DateFormat('dd.MM.yyyy').parse(value)));
                  }
                },
                key: key,
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  _DateInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: 'TT.MM.YYYY',
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
                  errorText: state.childInfo.birthDay.displayError != null
                      ? state.childInfo.birthDay.error?.message
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
                                  .read<KindPersonalInfoBloc>()
                                  .add(BirthDayChanged(birthDay: value));
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

class _CustomerInvitedFirstNameInput extends StatelessWidget {
  final TextEditingController controller;

  const _CustomerInvitedFirstNameInput({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.customerInvitedInfo.customerInvitedFirstName !=
          current.customerInvitedInfo.customerInvitedFirstName,
      builder: (context, state) {
        return TextField(
          controller: controller,
          onChanged: (firstName) => context
              .read<KindPersonalInfoBloc>()
              .add(CustomerInvitedFirstNameChanged(
                firstName: firstName,
              )),
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'Vorname der Eltern',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*', style: TextStyle(color: Colors.red, fontSize: 14)),
                ],
              ),
            ),
            errorText: state.customerInvitedInfo.customerInvitedFirstName
                        .displayError !=
                    null
                ? state
                    .customerInvitedInfo.customerInvitedFirstName.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _CustomerInvitedLastNameInput extends StatelessWidget {
  final TextEditingController controller;

  const _CustomerInvitedLastNameInput({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.customerInvitedInfo.customerInvitedLastName !=
          current.customerInvitedInfo.customerInvitedLastName,
      builder: (context, state) {
        return TextField(
          controller: controller,
          onChanged: (lastName) => context
              .read<KindPersonalInfoBloc>()
              .add(CustomerInvitedLastNameChanged(
                lastName: lastName,
              )),
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'Nachname der Eltern',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*', style: TextStyle(color: Colors.red, fontSize: 14)),
                ],
              ),
            ),
            errorText: state.customerInvitedInfo.customerInvitedLastName
                        .displayError !=
                    null
                ? state
                    .customerInvitedInfo.customerInvitedLastName.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _CustomerInvitedEmailInput extends StatelessWidget {
  final TextEditingController controller;

  const _CustomerInvitedEmailInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.customerInvitedInfo.customerInvitedEmail !=
            current.customerInvitedInfo.customerInvitedEmail,
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^[ctrl]+\s*v$')),
              // Disable all input
            ],
            contextMenuBuilder: null,
            onChanged: (email) => context
                .read<KindPersonalInfoBloc>()
                .add(CustomerInvitedEmailChanged(email: email)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Deine BESTE E-Mail',
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
              errorText:
                  state.customerInvitedInfo.customerInvitedEmail.displayError !=
                          null
                      ? state.customerInvitedInfo.customerInvitedEmail.error
                          ?.message
                      : null,
            ),
          );
        });
  }
}

class _CustomerInvitedPhoneNumberInputFlag extends StatelessWidget {
  final TextEditingController controller;

  const _CustomerInvitedPhoneNumberInputFlag({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.customerInvitedInfo.customerInvitedPhoneNumber !=
            current.customerInvitedInfo.customerInvitedPhoneNumber,
        builder: (context, state) {
          return InternationalPhoneNumberInput(
            textFieldController: controller,
            inputDecoration: InputDecoration(
              counterText: '',
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Handynummer',
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
              errorText: state.customerInvitedInfo.customerInvitedPhoneNumber
                          .displayError !=
                      null
                  ? state.customerInvitedInfo.customerInvitedPhoneNumber.error
                      ?.message
                  : null,
            ),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 20,
            ),
            hintText: 'Phone number',
            validator: (userInput) {
              if (userInput!.isEmpty) {
                return 'Please enter your phone number';
              }

              // Ensure it is only digits and optional '+' or '00' for the country code.
              if (!RegExp(r'^(\+|)?[0-9]+$').hasMatch(userInput)) {
                return 'Please enter a valid phone number';
              }

              return null; // Return null when the input is valid
            },
            onInputChanged: (PhoneNumber phoneNumber) {
              context.read<KindPersonalInfoBloc>().add(
                  CustomerInvitedPhoneNumberChanged(
                      phoneNumber: phoneNumber.phoneNumber!));
            },
            onInputValidated: (bool value) {},
            maxLength: 15,
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            // initialValue: number,
            // textFieldController: controller,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onSaved: (PhoneNumber number) {},
            locale: 'de',
            countries: const [
              'DE' /*, 'AT', 'CH'*/
            ],
            errorMessage: state.customerInvitedInfo.customerInvitedPhoneNumber
                        .displayError !=
                    null
                ? state.customerInvitedInfo.customerInvitedPhoneNumber.error
                    ?.message
                : null,
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindPersonalInfoBloc, KindPersonalInfoState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          var updatedChildInfo = context
              .read<SwimGeneratorCubit>()
              .state
              .kindPersonalInfo
              .childInfos[
                  context.read<SwimGeneratorCubit>().state.childInfoIndex]
              .copyWith(
                firstName: state.childInfo.firstName,
                lastName: state.childInfo.lastName,
                birthDay: state.childInfo.birthDay,
                kidsDevelopState: state.childInfo.kidsDevelopState,
                isPhysicalDelay: state.childInfo.isPhysicalDelay,
                isMentalDelay: state.childInfo.isMentalDelay,
                isNoLimit: state.childInfo.isNoLimit,
              );
          List<ChildInfo> updatedChildInfos = List.from(context
              .read<SwimGeneratorCubit>()
              .state
              .kindPersonalInfo
              .childInfos)
            ..[context.read<SwimGeneratorCubit>().state.childInfoIndex] =
                updatedChildInfo;

          var updatedGuardianInfo = context
              .read<SwimGeneratorCubit>()
              .state
              .kindPersonalInfo
              .customerInvitedInfos[
                  context.read<SwimGeneratorCubit>().state.childInfoIndex]
              .copyWith(
                customerInvitedFirstName:
                    state.customerInvitedInfo.customerInvitedFirstName,
                customerInvitedLastName:
                    state.customerInvitedInfo.customerInvitedLastName,
                customerInvitedEmail:
                    state.customerInvitedInfo.customerInvitedEmail,
                customerInvitedPhoneNumber:
                    state.customerInvitedInfo.customerInvitedPhoneNumber,
              );
          List<CustomerInvitedInfo> updatedCustomerInvitedInfos = List.from(
              context
                  .read<SwimGeneratorCubit>()
                  .state
                  .kindPersonalInfo
                  .customerInvitedInfos)
            ..[context.read<SwimGeneratorCubit>().state.childInfoIndex] =
                updatedGuardianInfo;
          context.read<SwimGeneratorCubit>().updateKindPersonalInfo(context
              .read<SwimGeneratorCubit>()
              .state
              .kindPersonalInfo
              .copyWith(
                childInfos: updatedChildInfos,
                childInfo: updatedChildInfos[0],
                customerInvitedInfos: updatedCustomerInvitedInfos,
              ));
          context
              .read<SwimGeneratorCubit>()
              .childInfoIndexContinued(state.childFriendSelected);
          if (context.read<SwimGeneratorCubit>().state.configApp.isCodeLinks) {
            SwimCourseInfo swimCourseInfo = SwimCourseInfo(
                swimCourse: state.swimCourseBookingByCode.swimCourse,
                isForMultiChild: false,
                childLength: 1);
            context
                .read<SwimGeneratorCubit>()
                .updateSwimCourseInfo(swimCourseInfo);

            List<SwimPoolInfo> swimPools = [];
            for (var swimPool in state.swimCourseBookingByCode.swimPools) {
              swimPools.add(SwimPoolInfo(
                  swimPool: swimPool,
                  swimPoolID: swimPool.swimPoolID,
                  swimPoolName: swimPool.swimPoolName,
                  isSelected: swimPool.isSelected));
            }
            context.read<SwimGeneratorCubit>().updateSwimPoolInfo(swimPools);
          }
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
                    ? () => context.read<KindPersonalInfoBloc>().add(
                        FormSubmitted(
                            selectedCourse: context
                                    .read<SwimGeneratorCubit>()
                                    .state
                                    .configApp
                                    .isCodeLinks
                                ? context
                                    .read<KindPersonalInfoBloc>()
                                    .state
                                    .swimCourseBookingByCode
                                    .swimCourse
                                : context
                                    .read<SwimGeneratorCubit>()
                                    .state
                                    .swimCourseInfo
                                    .swimCourse))
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
                  onPressed: () {
                    context.read<SwimGeneratorCubit>().stepCancelled();
                    context
                        .read<SwimGeneratorCubit>()
                        .childInfoIndexCancelled();
                  },
                  child: const Text('Zurück'),
                );
        });
  }
}
