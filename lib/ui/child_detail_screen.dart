import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/home.dart';
import 'package:baby_assistant/ui/log_drink_screen.dart';
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
  final List<DrinkActivity> _drinkList = <DrinkActivity>[];
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _readDrinkList();
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
              child: Text(
                dateNowFormatted(),
                style: TextStyle(fontSize: 18.0, color: Colors.white),
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
                        onTap: () {
                          int id = _drinkList[index].id;
                          _showDeleteDrinkDialog(id);
                        },
                      ),
                    );
                  }),
            ),
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
