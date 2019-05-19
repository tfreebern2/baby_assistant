import 'package:baby_assistant/model/ate_activity.dart';
import 'package:baby_assistant/model/change_activity.dart';
import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/home.dart';
import 'package:baby_assistant/ui/list/child_ate_list.dart';
import 'package:baby_assistant/ui/list/child_change_list.dart';
import 'package:baby_assistant/ui/list/child_drink_list.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:baby_assistant/widget/fab_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ChildDetailScreen extends StatefulWidget {
  final Child child;
  final FabList fabList;

  const ChildDetailScreen({Key key, this.child, this.fabList})
      : super(key: key);

  @override
  _ChildDetailScreenState createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends State<ChildDetailScreen> {
  var db = new DatabaseHelper();
  List<DrinkActivity> _drinkList = <DrinkActivity>[];
  List<AteActivity> _ateList = <AteActivity>[];
  List<ChangeActivity> _changeList = <ChangeActivity>[];

  @override
  void initState() {
    super.initState();
    _readDrinkList();
    _readAteList();
    _readChangeList();
  }

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
                child: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (context) => Home()));
                }),
            middle: Text(
                widget.child.firstName,
              style: TextStyle(color: Colors.white),
            ),
            trailing: CupertinoButton(
              child: Icon(Icons.more_horiz, color: Colors.white,),
              onPressed: () {
                FabList(child: widget.child);
              },
            ),
          ),
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      dateNowFormatted(),
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      _buildLastDrinkActivity(_drinkList),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildLastAteActivity(_ateList),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildLastChangeActivity(_changeList),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
//          floatingActionButton: FabList(
//            child: widget.child,
//          )
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }),
            title: Text(
              widget.child.firstName,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    dateNowFormatted(),
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    _buildLastDrinkActivity(_drinkList),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildLastAteActivity(_ateList),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildLastChangeActivity(_changeList)
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FabList(
            child: widget.child,
          ));
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

  Widget _buildLastDrinkActivity(List<DrinkActivity> drinkList) {
    if (drinkList.length == 0) {
      return Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListTile(
                title: Center(
                    child: Text(
                  'No recent Drink Activity',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('View Drink Logs'),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildDrinkList(
                                child: widget.child,
                              )));
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Card(
        child: ListTile(
            title: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Child - Drank',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Start Time: " + drinkList.last.startTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("End Time: " + drinkList.last.endTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  drinkList.last.amount + " ounce(s)",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('View Drink Logs'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildDrinkList(
                                  child: widget.child,
                                )));
                  },
                ),
              )
            ],
          ),
        )),
      );
    }
  }

  _readAteList() async {
    List ateActivityList = await db.getCurrentAteActivities(widget.child.id);
    ateActivityList.forEach((item) {
      setState(() {
        _ateList.add(AteActivity.map(item));
      });
    });
  }

  Widget _buildLastAteActivity(List<AteActivity> ateList) {
    if (ateList.length == 0) {
      return Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListTile(
                title: Center(
                    child: Text(
                  'No recent Ate Activity',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('View Ate Logs'),
                color: Colors.blue,
                onPressed: () {
                  if (isIOS) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                ChildAteList(
                                  child: widget.child,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChildAteList(
                                  child: widget.child,
                                )));
                  }
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Card(
        child: ListTile(
            title: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Child - Ate',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Start Time: " + ateList.last.startTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("End Time: " + ateList.last.endTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description: " + ateList.last.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ateList.last.amount + " ounce(s)",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('View Ate Logs'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildAteList(
                                  child: widget.child,
                                )));
                  },
                ),
              )
            ],
          ),
        )),
      );
    }
  }

  _readChangeList() async {
    List ateActivityList = await db.getCurrentAteActivities(widget.child.id);
    ateActivityList.forEach((item) {
      setState(() {
        _ateList.add(AteActivity.map(item));
      });
    });
  }

  Widget _buildLastChangeActivity(List<ChangeActivity> changeList) {
    if (changeList.length == 0) {
      return Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListTile(
                title: Center(
                    child: Text(
                  'No recent Change Activity',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('View Change Logs'),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildChangeList(
                                child: widget.child,
                              )));
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Card(
        child: ListTile(
            title: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Child - Ate',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Start Time: " + changeList.last.startTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("End Time: " + changeList.last.endTime),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description: " + changeList.last.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  changeList.last.description,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('View Ate Logs'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildChangeList(
                                  child: widget.child,
                                )));
                  },
                ),
              )
            ],
          ),
        )),
      );
    }
  }
}
