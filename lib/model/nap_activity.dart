import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class NapActivity {
  NapActivity({
    @required this.date,
    @required this.startTime,
    @required this.endTime
  });

  // date of nap
  final DateTime date;

  // start of nap
  final DateTime startTime;

  // end of nap
  final DateTime endTime;
}
