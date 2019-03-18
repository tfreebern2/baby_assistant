import 'package:baby_assistant/model/child.dart';
import 'package:flutter/material.dart';

class ChildDetailScreen extends StatelessWidget {
  final Child child;

  const ChildDetailScreen({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              child.firstName,
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
