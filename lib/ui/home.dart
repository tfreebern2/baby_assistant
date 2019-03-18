import 'package:baby_assistant/ui/child_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Baby Assistant'),
      ),
      body: ChildScreen(),
    );
  }
}