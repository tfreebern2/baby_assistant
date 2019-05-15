import 'package:baby_assistant/ui/child_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return isIOS ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Baby Assistant'),
//        leading: Text(''), // Hiding Back Button -- hacky solution
      ),
      child: ChildListScreen(),
    ) : Scaffold(
      appBar: AppBar(
        title: Text('Baby Assistant'),
        leading: Text(''), // Hiding Back Button -- hacky solution
        centerTitle: true,
      ),
      body: ChildListScreen(),
    );
  }
}