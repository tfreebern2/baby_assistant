import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:baby_assistant/util/database_helper.dart';
import 'package:flutter/material.dart';

class ChildScreen extends StatefulWidget {
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  var db = new DatabaseHelper();
  final List<Child> _childList = <Child>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: _childList.length,
            itemBuilder: (BuildContext context, int index) {},
          ),
        ),
      ],
    );
  }
}
