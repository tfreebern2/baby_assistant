import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';

class ChildDrinkLogScreen extends StatefulWidget {
  final Child child;

  const ChildDrinkLogScreen({Key key, this.child}) : super(key: key);

  @override
  _ChildDrinkLogScreenState createState() => _ChildDrinkLogScreenState();
}

class _ChildDrinkLogScreenState extends State<ChildDrinkLogScreen> {
  var db = new DatabaseHelper();
  final List<DrinkActivity> _drinkList = <DrinkActivity>[];

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
