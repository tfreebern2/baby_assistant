import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'model/child.dart';

class ChildListProvider with ChangeNotifier {
  var db = new DatabaseHelper();
  final logChildren = <Child>[];
  Child currentChild;

  ChildListProvider() {
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

  void setChild(Child child) async {
    currentChild = child;
    notifyListeners();
  }

  void getCurrentChild() {
    if (currentChild == null) {
      currentChild = logChildren[0];
    }
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
