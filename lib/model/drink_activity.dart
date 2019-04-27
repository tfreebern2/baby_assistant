import 'package:baby_assistant/model/child.dart';
import 'package:flutter/material.dart';

class DrinkActivity extends StatelessWidget {
  DrinkActivity(this._date, this._startTime, this._endTime,
      this._amount, this._childId);

  int _id;
  int _childId;
  String _date;
  String _startTime;
  String _endTime;
  String _description;
  String _amount;
  Child child;

//  Unit _unit;

  DrinkActivity.map(dynamic obj) {
    this._date = obj["date"];
    this._startTime = obj["start_time"];
    this._endTime = obj["end_time"];
    this._description = obj["description"];
    this._amount = obj["amount"];
//    this._unit = obj["unit"];

    this._childId = obj["childId"];
    this._id = obj["id"];
  }

  String get date => _date;

  String get startTime => _startTime;

  String get endTime => _endTime;

  String get description => _description;

  String get amount => _amount;

  int get childId => _childId;

  int get id => _id;

//  Unit get unit => _unit;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["description"] = _description;
    map["amount"] = _amount;
//    map["unit"] = _unit;
    map["childId"] = _childId;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  DrinkActivity.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._startTime = map["start_time"];
    this._endTime = map["end_time"];
    this._description = map["description"];
    this._amount = map["amount"];
//    this._unit = map["unit"];
    this._childId = map["childId"];

    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Child - Drank',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Start Time: " + _startTime.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("End Time: " + _endTime.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _amount + " ounce(s)",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}

//enum Unit { ounce }

//const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};
