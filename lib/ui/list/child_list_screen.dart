import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/child_provider.dart';
import 'package:baby_assistant/widget/cupertino_child_dialog.dart';
import 'package:baby_assistant/widget/material_child_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ChildListScreen extends StatefulWidget {
  const ChildListScreen({Key key}) : super(key: key);

  @override
  _ChildListScreenState createState() => _ChildListScreenState();
}

class _ChildListScreenState extends State<ChildListScreen> {
  @override
  Widget build(BuildContext context) {
    final childList = Provider.of<ChildProvider>(context, listen: true);
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Baby Assistant',
            style: TextStyle(color: Colors.white),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  itemCount: childList.logChildren.length,
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
                                    childList.logChildren[index].firstName
                                        .substring(0, 1),
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
                                  childList.logChildren[index].firstName,
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
                          _storeChild(childList.logChildren[index].id);
                          childList.setChild(childList.logChildren[index]);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ChildDetailScreen(
                                    child: childList.logChildren[index]),
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                itemCount: childList.logChildren.length,
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
                                  childList.logChildren[index].firstName
                                      .substring(0, 1),
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
                                childList.logChildren[index].firstName,
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
                              builder: (context) => ChildDetailScreen(
                                  child: childList.logChildren[index]),
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
    }
  }

  Future<List<Child>> _showChildFormMaterial() {
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

  _storeChild(int childId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("childId", childId);
  }

}
