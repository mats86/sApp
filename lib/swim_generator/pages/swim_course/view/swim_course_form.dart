import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/models/models.dart';
import 'package:swim_generator_app/util/util_time.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../bloc/swim_course_bloc.dart';

class SwimCourseForm extends StatefulWidget {
  const SwimCourseForm({super.key});

  @override
  State<SwimCourseForm> createState() => _SwimCourseForm();
}

class _SwimCourseForm extends State<SwimCourseForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimCourseBloc>().add(LoadSwimSeasonOptions());
    context.read<SwimCourseBloc>().add(LoadSwimCourseOptions(
        context.read<SwimGeneratorCubit>().state.swimLevel.swimLevel!,
        context.read<SwimGeneratorCubit>().state.birthDay.birthDay!,
        context
            .read<SwimGeneratorCubit>()
            .state
            .swimSeasonInfo
            .swimSeason!
            .refDate!));
    if (context
            .read<SwimGeneratorCubit>()
            .state
            .swimCourseInfo
            .swimCourse
            .swimCourseName !=
        '') {
      BlocProvider.of<SwimCourseBloc>(context).add(SwimCourseChanged(
          context
              .read<SwimGeneratorCubit>()
              .state
              .swimCourseInfo
              .swimCourse
              .swimCourseName,
          context.read<SwimGeneratorCubit>().state.swimCourseInfo.swimCourse));
      BlocProvider.of<SwimCourseBloc>(context).add(UpdateIsForMultiChild(context
          .read<SwimGeneratorCubit>()
          .state
          .swimCourseInfo
          .isForMultiChild));
      BlocProvider.of<SwimCourseBloc>(context).add(DropdownChanged(
          context.read<SwimGeneratorCubit>().state.swimCourseInfo.childLength));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimCourseBloc, SwimCourseState>(
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
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Dem Alter entsprechende Kurse:",
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
          const _SwimCourseRadioButton(),
          const DropdownMenuWidget(),
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

class _SwimCourseRadioButton extends StatelessWidget {
  const _SwimCourseRadioButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
        builder: (context, state) {
      return !state.loadingCourseStatus.isSuccess
          ? const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            )
          : Visibility(
              visible: state.swimCourseOptions.isNotEmpty,
              child: Column(
                children: [
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.separated(
                        separatorBuilder: (_, __) =>
                            Divider(color: Colors.grey[300]),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.swimCourseOptions.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<SwimCourseBloc>(context).add(
                                SwimCourseChanged(
                                  state.swimCourseOptions[index].swimCourseName,
                                  state.swimCourseOptions[index],
                                ),
                              );
                            },
                            child: SizedBox(
                              // height: 50,
                              child: Visibility(
                                visible: state.swimCourseOptions[index]
                                    .isSwimCourseVisible,
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.lightBlueAccent,
                                      groupValue: state.swimCourse.value,
                                      value: state.swimCourseOptions[index]
                                          .swimCourseName,
                                      onChanged: (val) {
                                        BlocProvider.of<SwimCourseBloc>(context)
                                            .add(SwimCourseChanged(
                                                val.toString(),
                                                state
                                                    .swimCourseOptions[index]));
                                      },
                                    ),
                                    Flexible(
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '${state.swimCourseOptions[index].swimCourseName} '
                                            'ab ${state.swimCourseOptions[index].swimCoursePrice} €',
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      preferBelow: false,
                                      message: state.swimCourseOptions[index]
                                          .swimCourseDescription,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.info_rounded,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          // context
                                          //     .read<SwimCourseBloc>()
                                          //     .add(WebPageLoading());

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(state
                                                    .swimCourseOptions[index]
                                                    .swimCourseName),
                                                content: state
                                                        .loadingWebPageStatus
                                                        .isInProgress
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : SizedBox(
                                                        height: 400,
                                                        width: 425,
                                                        child: InAppWebView(
                                                          initialUrlRequest: URLRequest(
                                                              url: WebUri(state
                                                                  .swimCourseOptions[
                                                                      index]
                                                                  .swimCourseUrl!)),
                                                        ),
                                                      ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text('Schließen'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: _MeinTextMitLink()),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            );
    });
  }
}

class DropdownMenuWidget extends StatelessWidget {
  const DropdownMenuWidget({super.key});

  List<int> generateNumberList(int start, int end) {
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
      builder: (context, state) {
        return state.selectedCourse.swimCourseGroupSize == 0
            ? const Center()
            : Visibility(
                visible: state.selectedCourse.swimCourseGroupSize > 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          children: [
                            Text(
                              state.selectedCourse.isAdultCourse
                                  ? 'Möchtest Du auch einen Freund anmelden?'
                                  : 'Möchtest Du Freunde oder eine Gruppe anmelden?',
                            ),
                          ],
                        ),
                        const Spacer(),
                        Switch(
                          // thumb color (round icon)
                          // activeColor: Colors.amber,
                          // activeTrackColor: Colors.cyan,
                          // inactiveThumbColor: Colors.blueGrey.shade600,
                          // inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: state.isForMultiChild,
                          // changes the state of the switch
                          onChanged: (value) =>
                              BlocProvider.of<SwimCourseBloc>(context)
                                  .add(ActiveMultiChild()),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Visibility(
                      visible: state.isForMultiChild,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Wähle die Anzahl aus',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const Spacer(),
                          DropdownButton<int>(
                            value: state.dropdownValue,
                            items: generateNumberList(
                                    1, state.selectedCourse.swimCourseGroupSize - 1)
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              // Senden Sie ein Update-Event an den BLoC
                              BlocProvider.of<SwimCourseBloc>(context)
                                  .add(DropdownChanged(newValue!));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimCourseBloc, SwimCourseState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          SwimCourseInfo swimCourseInfo = SwimCourseInfo(
              swimCourse: state.selectedCourse,
              isForMultiChild: state.isForMultiChild,
              childLength: state.dropdownValue);
          context
              .read<SwimGeneratorCubit>()
              .updateSwimCourseInfo(swimCourseInfo);

          if (state.selectedCourse.isAdultCourse) {
            context.read<SwimGeneratorCubit>().customizeSteps(
                state.selectedCourse.isAdultCourse, state.isForMultiChild);
          } else {
            if (state.isForMultiChild) {
              context
                  .read<SwimGeneratorCubit>()
                  .updateAddStepPages(state.dropdownValue + 1);
            } else {
              context.read<SwimGeneratorCubit>().updateAddStepPages(1);
            }
          }
          DateTime now = DateTime.now();
          int year = now.year;
          context.read<SwimGeneratorCubit>().updateConfigApp(
                isStartFixDate: now.isAfter(UtilTime().updateYear(
                            state.selectedCourse.swimCourseStartBooking!,
                            2023)) &&
                        now.isBefore(UtilTime().updateYear(
                            state.selectedCourse.swimCourseEndBooking!, year))
                    ? true
                    : false,
              );
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
            context.select((SwimCourseBloc bloc) => bloc.state.isValid);
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
                    ? () => context.read<SwimCourseBloc>().add(FormSubmitted())
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
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
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
      },
    );
  }
}

class _MeinTextMitLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: <TextSpan>[
          TextSpan(
            text: "¹ Übersicht aller von uns angebotenen Schwimmkurse",
            style: const TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                const url =
                    "https://wassermenschen-schwimmschulen.vercel.app/schwimmkurse";
                if (!await launchUrl(Uri.parse(url))) {
                  throw 'Could not launch $url';
                }
              },
          ),
          const TextSpan(text: "."),
        ],
      ),
    );
  }
}
