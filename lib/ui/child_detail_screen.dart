import 'package:baby_assistant/model/child.dart';
import 'package:flutter/material.dart';
import 'package:baby_assistant/util/date_helper.dart';

class ChildDetailScreen extends StatefulWidget {
  final Child child;

  const ChildDetailScreen({Key key, this.child}) : super(key: key);

  @override
  _ChildDetailScreenState createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends State<ChildDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Baby Assistant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                widget.child.firstName,
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${dateNowFormatted()}',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
