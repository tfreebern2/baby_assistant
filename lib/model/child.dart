import 'package:baby_assistant/model/routine.dart';

class Child {
  int _id;
  String _firstName;
  DateTime _dateOfBirth;
  Routine _routineId;

  Child(this._id, this._firstName, this._dateOfBirth, this._routineId);

  Child.map(dynamic obj) {
    this._firstName = obj["first_name"];
    this._dateOfBirth = obj["date_of_birth"];
    this._routineId = obj["routine_id"];

    this._id = obj["id"];
  }

  // Getters
  DateTime get dateOfBirth => _dateOfBirth;

  String get firstName => _firstName;

  Routine get routine => _routineId;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = _firstName;
    map["date_of_birth"] = _dateOfBirth;
    map["routine_id"] = _routineId;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Child.fromMap(Map<String, dynamic> map) {
    this._firstName = map["first_name"];
    this._dateOfBirth = map["date_of_birth"];
    this._routineId = map["routine_id"];
    this._id = map["id"];
  }
}
