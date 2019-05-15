import 'package:baby_assistant/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

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
    return isIOS ? CupertinoApp(
      title: 'Baby Assistant',
      home: Home(),
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    ) : MaterialApp(
      title: 'Baby Assistant',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
