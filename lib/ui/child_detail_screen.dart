import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';
import 'package:baby_assistant/util/date_helper.dart';

class ChildDetailScreen extends StatefulWidget {
  final Child child;

  const ChildDetailScreen({Key key, this.child}) : super(key: key);

  @override
  _ChildDetailScreenState createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends State<ChildDetailScreen> {
  var db = new DatabaseHelper();
  final List<DrinkActivity> _drinkList = <DrinkActivity>[];
  final _descriptionController = new TextEditingController();
  final _amountController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _readDrinkList();
  }

  void _handleSubmitted(String date, String startTime, String endTime,
      String description, String amount, int childId) async {
    _descriptionController.clear();
    _amountController.clear();
    DrinkActivity drinkActivity = new DrinkActivity(
        date, startTime, endTime, description, amount, childId);
    int savedDrinkActivityId = await db.saveDrinkActivity(drinkActivity);

    DrinkActivity addedDrinkActivity =
        await db.getDrinkActivity(savedDrinkActivityId, widget.child.id);

    setState(() {
      _drinkList.insert(0, addedDrinkActivity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Baby Assistant')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                widget.child.firstName,
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${dateNowFormatted()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                itemCount: _drinkList.length,
                itemBuilder: (_, int index) {
                  return Card(
                    child: ListTile(
                      title: _drinkList[index],
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: _buildFabs()
    );
  }

  Widget _buildFabs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 45.0,
            width: 45.0,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.grey,
                tooltip: 'Log Nap Activity',
                child: ListTile(
                  title: Icon(Icons.local_hotel),
                ),
                onPressed: () => debugPrint("Nap"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 45.0,
            width: 45.0,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.grey,
                tooltip: 'Log Changing Activity',
                child: ListTile(
                  title: Icon(Icons.child_care),
                ),
                onPressed: () => debugPrint("Change"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 45.0,
            width: 45.0,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.grey,
                tooltip: 'Log Eat Activity',
                child: ListTile(
                  title: Icon(Icons.restaurant),
                ),
                onPressed: () => debugPrint("Eat"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 45.0,
            width: 45.0,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.grey,
                tooltip: 'Log Drink Activity',
                child: ListTile(
                  title: Icon(Icons.local_drink),
                ),
                onPressed: () => debugPrint("Drink"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            tooltip: 'Add Activity',
            child: ListTile(
              title: Icon(Icons.menu),
            ),
            onPressed: _showFormDialog,
          ),
        ),
      ],
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: "Add description",
                  hintText: "eg. Something ...",
                  icon: Icon(Icons.note_add)),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                  labelText: "Add amount",
                  hintText: "eg. Something ...",
                  icon: Icon(Icons.note_add)),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmitted(
                dateNowFormattedForDb(),
                dateNowHourMinute(),
                dateNowHourMinute(),
                _descriptionController.text,
                _amountController.text,
                widget.child.id);
            _descriptionController.clear();
            _amountController.clear();
            // removes dialog box
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        FlatButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readDrinkList() async {
    List drinkActivityList = await db.getDrinkActivities(widget.child.id);
    drinkActivityList.forEach((item) {
      setState(() {
        _drinkList.add(DrinkActivity.map(item));
      });
    });
  }
}
