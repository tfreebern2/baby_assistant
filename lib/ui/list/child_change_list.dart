import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/change_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/material.dart';

class ChildChangeList extends StatefulWidget {
  final Child child;

  const ChildChangeList({Key key, this.child}) : super(key: key);

  @override
  _ChildChangeListState createState() => _ChildChangeListState();
}

class _ChildChangeListState extends State<ChildChangeList> {
  var db = new DatabaseHelper();
  final List<ChangeActivity> _changeList = <ChangeActivity>[];

  @override
  void initState() {
    super.initState();
    _readChangeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.child.firstName),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(
              'Change Logs',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Text(
            dateNowFormatted(),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                itemCount: _changeList.length,
                itemBuilder: (_, int index) {
                  return Card(
                      child: ListTile(
                        onLongPress: () {
                          _showDeleteChangeDialog(_changeList[index].id);
                        },
                        title: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Child - Change',
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  Text("Start Time: " + _changeList[index].startTime),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("End Time: " + _changeList[index].endTime),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _changeList[index].description,
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                )
                              ],
                            )),
                      ));
                }),
          ),
        ],
      ),
    );
  }

  _readChangeList() async {
    List changeActivityList =
    await db.getCurrentChangeActivities(widget.child.id);
    changeActivityList.forEach((item) {
      setState(() {
        _changeList.add(ChangeActivity.map(item));
      });
    });
  }

  _deleteChangeActivity(int id) async {
    await db.deleteDrinkActivity(id);
    setState(() {
      _changeList.removeWhere((item) => item.id == id);
    });
  }

  void _showDeleteChangeDialog(int id) {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: Text('Are you sure you want to delete this activity?'))
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _deleteChangeActivity(id);
            // removes dialog box
            Navigator.pop(context);
          },
          child: Text('Delete'),
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
}
