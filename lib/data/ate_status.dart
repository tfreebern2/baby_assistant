import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class AteStatus {
  AteStatus(
      {@required this.date,
      @required this.startTime,
      @required this.endTime,
      @required this.amount,
      @required this.unit,
      @required this.type});

  // date of eating
  final DateTime date;

  // start of eating
  final DateTime startTime;

  // end of eating
  final DateTime endTime;

  // numerical amount eaten
  final int amount;

  // unit of measurement
  final Unit unit;

  // type of food
  final String type;
}

enum Unit { ounce }

const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};
