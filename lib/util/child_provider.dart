import 'package:flutter/cupertino.dart';
import 'package:baby_assistant/model/child.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChildProvider with ChangeNotifier {
  Child currentChild;
  static const _childIdKey = 'childId';
  static const _childNameKey = 'childName';

  // Indicates whether a call to [_loadFromSharedPrefs] is in progress;
  Future<void> _loading;

  ChildProvider() {
    load();
  }

  void setChild(Child child) async {
    currentChild = child;
    _saveToSharedPreferences(currentChild);
    notifyListeners();
  }

  Future<void> getCurrentChild() {
    return _loadFromSharedPrefs();
//    return currentChild;
  }

  Future<void> load() {
    return _loading = _loadFromSharedPrefs();
  }

  Future<void> _saveToSharedPreferences(Child child) async {
    final prefs = await SharedPreferences.getInstance();
//    await prefs.setInt(_childIdKey, currentChild.id);
    await prefs.setString(_childNameKey, child.firstName);
    notifyListeners();
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
//    currentChild.id = prefs.getInt(_childIdKey) ?? 999;
    if (currentChild == null) {
      currentChild = new Child("Blank");
    }
    currentChild.firstName = prefs.getString(_childNameKey) ?? "Blank";
    notifyListeners();
  }
}