import 'package:baby_assistant/model/child.dart';
import 'package:flutter/foundation.dart';

import 'database_client.dart';

class ChildList with ChangeNotifier {
  var db = new DatabaseHelper();

  ChildList() {
    _readChildList().then((list) {
      logChildren.addAll(list);
      notifyListeners();
    });
  }

  final logChildren = <Child>[];

  List<Child> get children {
    return logChildren.map<Child>((x) => Child.map(x)).toList();
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
