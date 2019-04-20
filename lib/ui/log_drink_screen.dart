import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class LogDrink extends StatefulWidget {
  final Child child;
  final int childId;

  const LogDrink({Key key, this.child, this.childId}) : super(key: key);

  @override
  _LogDrinkState createState() => _LogDrinkState();
}

class _LogDrinkState extends State<LogDrink> {
  var db = new DatabaseHelper();
  DateTime selectedStartTime;
  DateTime selectedEndTime;
  bool editable = true;
  DateTime date;

  // Controllers
  final _startTimeController = new TextEditingController();
  final _endTimeController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Drink Activity'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DateTimePickerFormField(
              controller: _startTimeController,
              inputType: InputType.time,
              format: DateFormat("HH:mm a"),
              editable: editable,
              decoration: InputDecoration(
                labelText: 'Start Time',
                hasFloatingPlaceholder: false,
              ),
              onChanged: (st) => setState(() => selectedStartTime = st),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DateTimePickerFormField(
              controller: _endTimeController,
              inputType: InputType.time,
              format: DateFormat("HH:mm a"),
              editable: editable,
              decoration: InputDecoration(
                labelText: 'End Time',
                hintText: 'Enter an ending time',
                hasFloatingPlaceholder: false,
              ),
              onChanged: (et) => setState(() => selectedEndTime = et),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
            child: TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a small description',
                  hintMaxLines: 3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount your child drank'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FlatButton(
                child: Text('Save'),
                color: Colors.grey,
                onPressed: () {
                  _drinkSubmitted(
                      DateTime.now().toIso8601String(),
                      _startTimeController.text,
                      _endTimeController.text,
                      _descriptionController.text,
                      _amountController.text,
                      widget.childId);
                }),
          ),
        ],
      ),
    );
  }

  void _drinkSubmitted(String date, String startTime, String endTime,
      String description, String amount, int childId) async {
    _startTimeController.clear();
    _endTimeController.clear();
    _descriptionController.clear();
    _amountController.clear();

    DrinkActivity drinkActivity = new DrinkActivity(
        date, startTime, endTime, description, amount, childId);

    await db.saveDrinkActivity(drinkActivity);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChildDetailScreen(
                  child: widget.child,
                )));
  }
}
