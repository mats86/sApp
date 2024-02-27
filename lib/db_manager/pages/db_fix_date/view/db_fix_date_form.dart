import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';

import '../../../../swim_generator/pages/date_selection/model/model.dart';
import '../../../../swim_generator/pages/swim_course/models/swim_course.dart';
import '../bloc/db_fix_date_bloc.dart';

class DbFixDateForm extends StatefulWidget {
  const DbFixDateForm({
    super.key,
  });

  @override
  State<DbFixDateForm> createState() => _DbFixDateForm();
}

class _DbFixDateForm extends State<DbFixDateForm> {
  @override
  void initState() {
    super.initState();
    context.read<DbFixDateBloc>().add(LoadFixDateOptions());
    context.read<DbFixDateBloc>().add(LoadSwimCourseOptions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DbFixDateBloc, DbFixDateState>(
      listener: (context, state) {
        if (false) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: const ExpandableListViewPage(),
    );
  }
}

class ExpandableListViewPage extends StatelessWidget {
  const ExpandableListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbFixDateBloc, DbFixDateState>(
        builder: (context, state) {
          return !state.loadingFixDateStatus.isSuccess
              ? const SpinKitWaveSpinner(
            color: Colors.lightBlueAccent,
            size: 50.0,
          )
              : Scaffold(
            appBar: AppBar(
              title: const Text('Beispiel AppBar'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final myBloc = BlocProvider.of<DbFixDateBloc>(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Buchungsdetails'),
                          content: SingleChildScrollView(
                            child: SwimForm(myBloc: myBloc),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Abbrechen'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Buchen'),
                              onPressed: () {
                                // Hier Logik zum Buchen hinzufügen
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: SfDataGrid(
              source: FixDateDataSource(fixDateData: state.fixDateOptions),
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'fixDateID',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('ID'),
                    )),
                GridColumn(
                    columnName: 'swimPoolID',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('PoolID'),
                    )),
                GridColumn(
                    columnName: 'swimCourseID',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('CourseID'),
                    )),
                GridColumn(
                    columnName: 'fixDateFrom',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('From'),
                    )),
                GridColumn(
                    columnName: 'fixDateTo',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('To'),
                    )),
                GridColumn(
                    columnName: 'isFixDateActive',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('isActive'),
                    )),
              ],
            ),
          );
        });
  }
}

class FixDateDataSource extends DataGridSource {
  /// Erstellt die FixDateDataSource Klasse mit erforderlichen Details.
  FixDateDataSource({required List<FixDateDetail> fixDateData}) {
    _fixDateData = fixDateData
        .map<DataGridRow>((fixDate) => DataGridRow(cells: [
      DataGridCell<int>(
          columnName: 'fixDateID', value: fixDate.fixDateID),
      DataGridCell<String>(
          columnName: 'swimPoolID', value: fixDate.swimPoolName),
      DataGridCell<String>(
          columnName: 'swimCourseID', value: fixDate.swimCourseName),
      DataGridCell<DateTime?>(
          columnName: 'fixDateFrom', value: fixDate.fixDateFrom),
      DataGridCell<DateTime?>(
          columnName: 'fixDateTo', value: fixDate.fixDateTo),
      DataGridCell<bool>(
          columnName: 'isFixDateActive',
          value: fixDate.isFixDateActive),
    ]))
        .toList();
  }

  List<DataGridRow> _fixDateData = [];

  @override
  List<DataGridRow> get rows => _fixDateData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}

class SwimForm extends StatefulWidget {
  final DbFixDateBloc myBloc;
  const SwimForm({super.key, required this.myBloc});

  @override
  SwimFormState createState() => SwimFormState();
}

class SwimFormState extends State<SwimForm> {
  String? selectedSwimCourse;
  String? selectedSwimPool;
  DateTime? selectedDate;
  TimeOfDay? timeFrom;
  TimeOfDay? timeTo;

  List<String> swimPools = ['Pool A', 'Pool B', 'Pool C', 'Pool D'];
  late String selectedSwimCourseID = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwimCourseDropdown(
            swimCourseOptions: widget.myBloc.state.swimCourseOptions),
        DropdownButton<String>(
          hint: const Text('Wähle Schwimmbad'),
          value: selectedSwimPool,
          onChanged: (newValue) {
            setState(() {
              selectedSwimPool = newValue;
            });
          },
          items: swimPools.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Wähle Datum'),
        ),
        ElevatedButton(
          onPressed: () => _selectTime(context, true),
          child: const Text('Startzeit wählen'),
        ),
        ElevatedButton(
          onPressed: () => _selectTime(context, false),
          child: const Text('Endzeit wählen'),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
      isFrom ? timeFrom ?? TimeOfDay.now() : timeTo ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          timeFrom = picked;
        } else {
          timeTo = picked;
        }
      });
    }
  }
}

class SwimCourseDropdown extends StatefulWidget {
  final List<SwimCourse> swimCourseOptions;

  const SwimCourseDropdown({super.key, required this.swimCourseOptions});

  @override
  SwimCourseDropdownState createState() => SwimCourseDropdownState();
}

class SwimCourseDropdownState extends State<SwimCourseDropdown> {
  int? selectedCourseId;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownButton<int>(
          hint: const Text("Select Swim Course"),
          value: selectedCourseId,
          onChanged: (newValue) {
            setState(() {
              selectedCourseId = newValue;
            });
          },
          isExpanded: true, // Add this line
          items: widget.swimCourseOptions.map((SwimCourse course) {
            String displayName = course.swimCourseName +
                ((course.swimLevelID == 2) ? " - AUFSTEIGER" : "");
            return DropdownMenuItem<int>(
              value: course.swimCourseID,
              child: Text(displayName),
            );
          }).toList(),
        ));
  }
}
