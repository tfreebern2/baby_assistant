import 'package:baby_assistant/ui/child_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Assistant'),
        centerTitle: true,
      ),
      body: ChildScreen(),
    );
  }
}