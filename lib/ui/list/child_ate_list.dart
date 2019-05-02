import 'dart:async';

import 'package:baby_assistant/model/ate_activity.dart';
import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/material.dart';

class ChildAteList extends StatefulWidget {
  final Child child;

  const ChildAteList({Key key, this.child}) : super(key: key);

  @override
  _ChildAteListState createState() => _ChildAteListState();
}

class _ChildAteListState extends State<ChildAteList> {
  var db = new DatabaseHelper();
  final List<AteActivity> _ateList = <AteActivity>[];

  @override
  void initState() {
    super.initState();
    _readAteList();
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
              'Ate Logs',
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
                itemCount: _ateList.length,
                itemBuilder: (_, int index) {
                  return Card(
                      child: ListTile(
                        onLongPress: () {
                          _showDeleteAteDialog(_ateList[index].id);
                        },
                    title: Container(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Child - Ate',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("Start Time: " + _ateList[index].startTime),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("End Time: " + _ateList[index].endTime),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Description: " + _ateList[index].description),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _ateList[index].amount,
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

  _readAteList() async {
    List ateActivityList = await db.getCurrentAteActivities(widget.child.id);
    ateActivityList.forEach((item) => setState(() {
          _ateList.add(AteActivity.map(item));
        }));
  }

  _deleteAteActivity(int id) async {
    await db.deleteAteActivity(id);
    setState(() {
      _ateList.removeWhere((item) => item.id == id);
    });
  }

  void _showDeleteAteDialog(int id) {
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
            _deleteAteActivity(id);
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
