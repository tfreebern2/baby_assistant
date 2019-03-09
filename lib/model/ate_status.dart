import 'package:flutter/material.dart';

enum Unit { ounce }

const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};

class AteStatus extends StatelessWidget {
  AteStatus({this.date, this.startTime, this.endTime, this.amount, this.unit, this.type});

  // id
  int id;

  // date of eating
  DateTime date;

  // start of eating
  DateTime startTime;

  // end of eating
  DateTime endTime;

  // numerical amount eaten
  int amount;

  // unit of measurement
  Unit unit;

  // type of food
  String type;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}



