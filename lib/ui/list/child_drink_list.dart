import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ChildDrinkList extends StatefulWidget {
  final Child child;

  const ChildDrinkList({Key key, this.child}) : super(key: key);

  @override
  _ChildDrinkListState createState() => _ChildDrinkListState();
}

class _ChildDrinkListState extends State<ChildDrinkList> {
  var db = new DatabaseHelper();
  final List<DrinkActivity> _drinkList = <DrinkActivity>[];

  @override
  void initState() {
    super.initState();
    _readDrinkList();
  }

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: Colors.blueGrey,
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.child.firstName, style: TextStyle(color: Colors.white),),
          leading: CupertinoButton(
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.0),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChildDetailScreen(
                              child: widget.child,
                            )));
              }),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'Drink Logs',
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
                    itemCount: _drinkList.length,
                    itemBuilder: (_, int index) {
                      return Card(
                          child: ListTile(
                            onLongPress: () {
                              _showDeleteDrinkDialog(_drinkList[index].id);
                            },
                            title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Child - Drank',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Text("Start Time: " +
                                          _drinkList[index].startTime),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("End Time: " +
                                          _drinkList[index].endTime),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _drinkList[index].amount + " ounce(s)",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    )
                                  ],
                                )),
                          ));
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
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
                'Drink Logs',
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
                  itemCount: _drinkList.length,
                  itemBuilder: (_, int index) {
                    return Card(
                        child: ListTile(
                          onLongPress: () {
                            _showDeleteDrinkDialog(_drinkList[index].id);
                          },
                          title: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Child - Drank',
                                      style: TextStyle(
                                          fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    Text("Start Time: " + _drinkList[index].startTime),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("End Time: " + _drinkList[index].endTime),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _drinkList[index].amount + " ounce(s)",
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
  }

  _readDrinkList() async {
    List drinkActivityList =
        await db.getCurrentDrinkActivities(widget.child.id);
    drinkActivityList.forEach((item) {
      setState(() {
        _drinkList.add(DrinkActivity.map(item));
      });
    });
  }

  _deleteDrinkActivity(int id) async {
    await db.deleteDrinkActivity(id);
    setState(() {
      _drinkList.removeWhere((item) => item.id == id);
    });
  }

  void _showDeleteDrinkDialog(int id) {
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
            _deleteDrinkActivity(id);
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
