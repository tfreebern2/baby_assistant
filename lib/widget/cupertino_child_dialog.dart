import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_text_form_field.dart';

class CupertinoChildDialog extends StatefulWidget {
  final String name;

  const CupertinoChildDialog({Key key, this.name}) : super(key: key);

  @override
  _CupertinoChildDialogState createState() => _CupertinoChildDialogState();
}

class _CupertinoChildDialogState extends State<CupertinoChildDialog> {
  final _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  String _checkNewName;
  bool _resetValidate = false;

  bool _sendNewName(String name) {
    _checkNewName = name;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        _handleSubmitted(name);
        return true;
      } catch (exception) {
        print(exception);
      }
    } else {
      setState(() {
        _resetValidate = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Row(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: _resetValidate,
            child: Expanded(
              child: CupertinoTextFormField(
                validator: validateName,
                controller: _textEditingController,
                autofocus: true,
                placeholder: 'Logan, Sara, ...',
                placeholderStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoButton(
          onPressed: () {
            if (_sendNewName(_textEditingController.text)) {
              Navigator.pop(context);
            }
            // removes dialog box
          },
          child: Text('Save'),
        ),
        CupertinoButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    Child child = new Child(text);
    await db.saveChild(child);
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "Name is required";
    } else {
      return null;
    }
  }
}