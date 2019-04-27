import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/home.dart';
import 'package:baby_assistant/ui/list/child_drink_list.dart';
import 'package:baby_assistant/ui/log/log_drink_activity.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:flutter/material.dart';

class ChildDetailScreen extends StatefulWidget {
  final Child child;

  const ChildDetailScreen({Key key, this.child}) : super(key: key);

  @override
  _ChildDetailScreenState createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends State<ChildDetailScreen> {
  var db = new DatabaseHelper();
  List<DrinkActivity> _drinkList = <DrinkActivity>[];
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _opacity = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
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
                children: <Widget>[_buildLastDrinkActivity(_drinkList)],
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RaisedButton(
                  child: Text('View Drink Log'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChildDrinkList(
                                child: widget.child,
                              ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
        floatingActionButton: _buildFabList());
  }

  Widget _buildFabList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogDrink(
                                child: widget.child,
                                childId: widget.child.id,
                              ),
                        ));
                  },
                ),
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
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                });
              }),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _readDrinkList() async {
    List drinkActivityList =
        await db.getCurrentDrinkActivities(widget.child.id);
    drinkActivityList.forEach((item) {
      setState(() {
        _drinkList.add(DrinkActivity.map(item));
      });
    });
    return drinkActivityList;
  }

  Widget _buildLastDrinkActivity(List<DrinkActivity> drinkList) {
    return FutureBuilder(
        future: _readDrinkList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListTile(
                  title: Center(
                      child: Text(
                    'No recent Drink Activity',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            );
          } else {
            return Card(
              child: ListTile(
                title: drinkList.last,
              ),
            );
          }
        });
  }
}
