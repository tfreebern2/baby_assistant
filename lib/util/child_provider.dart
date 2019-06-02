import 'package:baby_assistant/model/child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'database_client.dart';

class ChildProvider with ChangeNotifier {
  var db = new DatabaseHelper();

  ChildProvider() {
    _readChildList().then((list) {
      logChildren.addAll(list);
      notifyListeners();
    });
  }

  final logChildren = <Child>[];
  var currentChild = Child;
  Child curr;

  List<Child> get children {
    return logChildren.map<Child>((x) => Child.map(x)).toList();
  }

  // TODO: Check to see if this works
  void setChild(Child child) {
    curr = child;
    notifyListeners();
  }

  Child getChild(Child child) {
    child = curr;
    notifyListeners();
    return child;
  }

  Future<List<Child>> _readChildList() async {
    List children = await db.getChildren();
    if (children.length > 0) {
      return children.map<Child>((x) => Child.fromMap(x)).toList();
    } else {
      return <Child>[];
    }
  }

  void addChild(Child child) {
    logChildren.add(child);
    _saveChild(child.firstName);
    notifyListeners();
  }

  void _saveChild(String name) async {
    Child child = new Child(name);
    await db.saveChild(child);
    notifyListeners();
  }
}
