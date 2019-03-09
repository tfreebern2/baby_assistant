import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(BabyAssistant());
}

class BabyAssistant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

