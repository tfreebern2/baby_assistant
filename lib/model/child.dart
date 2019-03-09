import 'package:baby_assistant/model/routine.dart';

class Child {
  int _id;
  String _firstName;
  DateTime _dateOfBirth;
  Routine _routine;

  Child(this._id, this._firstName, this._dateOfBirth, this._routine);

  Child.map(dynamic obj) {
    this._firstName = obj["firstName"];
    this._dateOfBirth = obj["dateOfBirth"];
    this._routine = obj["routine"];

    this._id = obj["id"];
  }

  // Getters
  DateTime get dateOfBirth => _dateOfBirth;

  String get firstName => _firstName;

  Routine get routine => _routine;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstName"] = _firstName;
    map["dateOfBirth"] = _dateOfBirth;
    map["routine"] = _routine;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Child.fromMap(Map<String, dynamic> map) {
    this._firstName = map["firstName"];
    this._dateOfBirth = map["dateOfBirth"];
    this._routine = map["routine"];
    this._id = map["id"];
  }
}
