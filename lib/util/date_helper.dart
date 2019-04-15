import 'package:intl/intl.dart';

String dateNowFormatted() {
  var now = DateTime.now();
  var formatter = new DateFormat.yMMMMd("en_US");

  String formatted = formatter.format(now);

  return formatted;
}

String string = new DateFormat() as String;