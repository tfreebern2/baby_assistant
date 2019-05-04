import 'package:baby_assistant/model/change_activity.dart';
import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class LogChange extends StatefulWidget {
  final Child child;
  final int childId;

  const LogChange({Key key, this.child, this.childId}) : super(key: key);

  @override
  _LogChangeState createState() => _LogChangeState();
}

class _LogChangeState extends State<LogChange> {
  var db = new DatabaseHelper();
  DateTime selectedStartTime;
  DateTime selectedEndTime;
  bool editable = true;

  // Controllers
  final _startTimeController = new TextEditingController();
  final _endTimeController = new TextEditingController();
  final _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Change Activity'),
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
                hintText: 'Enter a starting time',
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
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter the condition of your child\'s BM'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FlatButton(
                child: Text('Save'),
                color: Colors.grey,
                onPressed: () {
                  _changeSubmitted(
                      dateNowFormattedForDb(),
                      _startTimeController.text,
                      _endTimeController.text,
                      _descriptionController.text,
                      widget.childId);
                }),
          ),
        ],
      ),
    );
  }

  void _changeSubmitted(String date, String startTime, String endTime,
      String description, int childId) async {
    _startTimeController.clear();
    _endTimeController.clear();
    _descriptionController.clear();

    ChangeActivity changeActivity = new ChangeActivity(
        childId, date, startTime, endTime, description);

    await db.saveChangeActivity(changeActivity);

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
