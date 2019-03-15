import 'package:baby_assistant/ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(BabyAssistant());
// {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
// }


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
