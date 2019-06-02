import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/util/child_provider.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ChildListCallback = void Function(List<Child> childList);

class MaterialChildDialog extends StatefulWidget {
  final List<Child> childList;

  const MaterialChildDialog({Key key, this.childList}) : super(key: key);

  @override
  _MaterialChildDialogState createState() => _MaterialChildDialogState();
}

class _MaterialChildDialogState extends State<MaterialChildDialog> {
  final _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final _materialChildDialogKey = GlobalKey<FormState>();
  String _checkNewName;
  bool _nameValidate = false;

  _sendNewName(String name) {
    _checkNewName = name;

    if (_materialChildDialogKey.currentState.validate()) {
      _materialChildDialogKey.currentState.save();

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
            key: _materialChildDialogKey,
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
    final childList = Provider.of<ChildProvider>(context, listen: true);
    _textEditingController.clear();
    Child child = new Child(text);
    childList.addChild(child);
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "Name is required";
    } else {
      return null;
    }
  }
}
