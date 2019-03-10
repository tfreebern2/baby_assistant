import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class ChangeActivity {
  ChangeActivity(
      {@required this.date,
      @required this.time,
      @required this.description,
      @required this.condition});

  // date of change
  final DateTime date;

  // time of change
  final DateTime time;

  // description of change
  final String description;

  // condition of change
  final Condition condition;
}

enum Condition {
  wet,
  normalBM,
}

const Map<Condition, String> typesOfBM = {
  Condition.wet: 'Wet',
  Condition.normalBM: 'Normal BM'
};
