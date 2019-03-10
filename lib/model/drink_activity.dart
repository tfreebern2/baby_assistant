import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class DrinkActivity {
  DrinkActivity({
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.description,
    @required this.amount,
    @required this.unit,
  });

  // date of drinking
  final DateTime date;

  // start of drinking
  final DateTime startTime;

  // end of drinking
  final DateTime endTime;

  // description
  final String description;

  // numerical amount drank
  final int amount;

  // unit of measurement
  final Unit unit;
}

enum Unit { ounce }

const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};
