import 'package:baby_assistant/ui/child_screen.dart';
import 'package:baby_assistant/ui/home.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  runApp(BabyAssistant());
}

class BabyAssistant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Assistant',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
