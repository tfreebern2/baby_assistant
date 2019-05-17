import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/widget/cupertino_child_dialog.dart';
import 'package:baby_assistant/widget/material_child_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isAndroid =>
    foundation.defaultTargetPlatform == TargetPlatform.android;

class ChildListScreen extends StatefulWidget {
  @override
  _ChildListScreenState createState() => _ChildListScreenState();
}

class _ChildListScreenState extends State<ChildListScreen> {
  var db = new DatabaseHelper();
  final List<Child> _childList = <Child>[];
  final _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _readChildList();
  }

  void handleSubmitted(String text) async {
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
    if (isAndroid) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                itemCount: _childList.length,
                itemBuilder: (_, int index) {
                  return Card(
                    child: ListTile(
                      title: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  _childList[index].firstName.substring(0, 1),
                                  style: TextStyle(color: Colors.white),
                                ),
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 9.0, left: 5.0),
                              child: Text(
                                _childList[index].firstName,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.9),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChildDetailScreen(child: _childList[index]),
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
          onPressed: _showChildFormMaterial,
        ),
      );
    } else {
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  itemCount: _childList.length,
                  itemBuilder: (_, int index) {
                    return Card(
                      child: ListTile(
                        title: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _childList[index].firstName.substring(0, 1),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 9.0, left: 5.0),
                                child: Text(
                                  _childList[index].firstName,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.9),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ChildDetailScreen(child: _childList[index]),
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
              CupertinoButton(
                child: Text('Add Child'),
                color: Colors.blue,
                onPressed: _showChildFormIos,
              )
            ],
          ),
        ),
      );
    }
  }

  Future<String> _showChildFormMaterial() {
    return showDialog(
        context: context,
        builder: (_) {
          return MaterialChildDialog();
        });
  }

  Future<String> _showChildFormIos() {
    return showCupertinoDialog<String>(
        context: context,
        builder: (_) {
          return CupertinoChildDialog();
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

