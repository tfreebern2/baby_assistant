import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

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

  // Controllers
  final _startTimeController = new TextEditingController();
  final _endTimeController = new TextEditingController();
  final _amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Log Drink Activity'),
          leading: CupertinoButton(
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.0),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChildDetailScreen(
                              child: widget.child,
                            )));
              }),
        ),
        // TODO: Add form validation
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DateTimePickerFormField(
                  controller: _startTimeController,
                  inputType: InputType.time,
                  format: DateFormat.jm(),
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
                  format: DateFormat.jm(),
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
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
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
                          dateNowFormattedForDb(),
                          _startTimeController.text,
                          _endTimeController.text,
                          _amountController.text,
                          widget.childId);
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Log Drink Activity'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildDetailScreen(
                          child: widget.child,
                        )));
              }),
        ),
        // TODO: Add form validation
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DateTimePickerFormField(
                controller: _startTimeController,
                inputType: InputType.time,
                format: DateFormat.jm(),
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
                format: DateFormat.jm(),
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
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
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
                        dateNowFormattedForDb(),
                        _startTimeController.text,
                        _endTimeController.text,
                        _amountController.text,
                        widget.childId);
                  }),
            ),
          ],
        ),
      );
    }
  }

  void _drinkSubmitted(String date, String startTime, String endTime,
      String amount, int childId) async {
    _startTimeController.clear();
    _endTimeController.clear();
    _amountController.clear();

    DrinkActivity drinkActivity = new DrinkActivity(
        date, startTime, endTime, amount, childId);

    await db.saveDrinkActivity(drinkActivity);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChildDetailScreen(
                  child: widget.child,
                )
        )
    );
  }
}
