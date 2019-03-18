import 'package:flutter/material.dart';

class Child extends StatelessWidget {
  int _id;
  String _firstName;

  Child(this._firstName);

  Child.map(dynamic obj) {
    this._firstName = obj["first_name"];

    this._id = obj["id"];
  }

  // Getters
  String get firstName => _firstName;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = _firstName;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Child.fromMap(Map<String, dynamic> map) {
    this._firstName = map["first_name"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                _firstName.substring(0, 1),
                style: TextStyle(color: Colors.white),
              ),
              height: 30.0,
              width: 30.0,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 9.0, left: 5.0),
            child: Text(
              _firstName,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.9),
            ),
          )
        ],
      ),
    );
  }
}
