import 'package:flutter/material.dart';

class LogDrink extends StatefulWidget {
  @override
  _LogDrinkState createState() => _LogDrinkState();
}

class _LogDrinkState extends State<LogDrink> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Assistant'),),
      body: ListView(
        children: <Widget>[
          RaisedButton(onPressed: () => _selectDate(context),
            child: Text('Select Date'),

          )
        ],
      ),
    );
  }
}
