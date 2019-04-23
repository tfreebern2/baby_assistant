import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/ui/child_drink_log_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';

class ChildScreen extends StatefulWidget {
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  var db = new DatabaseHelper();
  final List<Child> _childList = <Child>[];
  final _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _readChildList();
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    Child child = new Child(text);
    int savedChildId = await db.saveChild(child);

    Child addedChild = await db.getChild(savedChildId);

    setState(() {
      _childList.insert(0, addedChild);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              itemCount: _childList.length,
              itemBuilder: (_, int index) {
                return Card(
                  child: ListTile(
                    title: _childList[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChildDrinkLogScreen(child: _childList[index]),
                          ));
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 20.0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Child',
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showChildForm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
//        BottomNavigationBarItem(
//            icon: Icon(Icons.home, color: Colors.blueGrey),
//            title: Text(
//              'Home',
//              style: TextStyle(color: Colors.blueGrey),
//            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_drink, color: Colors.blueGrey),
            title: Text('Drink Log', style: TextStyle(color: Colors.blueGrey))),
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, color: Colors.blueGrey),
            title: Text('Food Log', style: TextStyle(color: Colors.blueGrey))),
        BottomNavigationBarItem(
            icon: Icon(Icons.child_care, color: Colors.blueGrey),
            title:
                Text('Change Log', style: TextStyle(color: Colors.blueGrey))),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hotel, color: Colors.blueGrey),
            title: Text('Nap Log', style: TextStyle(color: Colors.blueGrey))),
      ]),
    );
  }

  void _showChildForm() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "eg. Logan, Sara, ...",
                  icon: Icon(Icons.child_care)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
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

  _readChildList() async {
    List children = await db.getChildren();
    children.forEach((item) {
      setState(() {
        _childList.add(Child.map(item));
      });
    });
  }
}
