import 'package:baby_assistant/model/child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_client.dart';

class ChildProvider with ChangeNotifier {
  var db = new DatabaseHelper();
  final logChildren = <Child>[];
  Child currentChild;

  ChildProvider() {
    _readChildList().then((list) {
      logChildren.addAll(list);
      notifyListeners();
    });
  }

  List<Child> get children {
    return logChildren.map<Child>((x) => Child.map(x)).toList();
  }

  Child get child {
    return child;
  }

  void setChild(Child child) {
    currentChild = child;
    notifyListeners();
  }

  Child initializeChild() {
    if (currentChild == null) {
      currentChild = logChildren[0];
    }
    return currentChild;
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
