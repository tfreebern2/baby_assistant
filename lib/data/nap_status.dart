import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class NapStatus {
  NapStatus({
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.length
  });

  // date of nap
  final DateTime date;

  // start of nap
  final DateTime startTime;

  // end of nap
  final DateTime endTime;

  // length of nap
  final DateTime length;
}
