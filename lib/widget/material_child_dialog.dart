import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';

class MaterialChildDialog extends StatefulWidget {
  final String name;

  const MaterialChildDialog({Key key, this.name}) : super(key: key);

  @override
  _MaterialChildDialogState createState() => _MaterialChildDialogState();
}

class _MaterialChildDialogState extends State<MaterialChildDialog> {
  final _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<Child> _childList = <Child>[];
  final _materialChildKey = GlobalKey<FormState>();
  String _checkNewName;
  bool _nameValidate = false;

  bool _sendNewName(String name) {
    _checkNewName = name;

    if (_materialChildKey.currentState.validate()) {
      _materialChildKey.currentState.save();

      try {
        _handleSubmitted(name);
        return true;
      } catch (exception) {
        print(exception);
      }
    } else {
      setState(() {
        _nameValidate = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: <Widget>[
          Form(
            key: _materialChildKey,
            autovalidate: _nameValidate,
            child: Expanded(
              child: TextFormField(
                validator: validateName,
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "First Name",
                    hintText: "eg. Logan, Sara, ...",
                    icon: Icon(Icons.child_care)),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (_sendNewName(_textEditingController.text)) {
              Navigator.pop(context);
            }// removes dialog box
          },
          child: Text('Save'),
        ),
        FlatButton(
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
    int savedChildId = await db.saveChild(child);

    Child addedChild = await db.getChild(savedChildId);

    setState(() {
      _childList.insert(0, addedChild);
    });
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "Name is required";
    } else {
      return null;
    }
  }
}
