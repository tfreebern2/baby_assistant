import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/ui/log/log_ate_activity.dart';
import 'package:baby_assistant/ui/log/log_change_activity.dart';
import 'package:baby_assistant/ui/log/log_drink_activity.dart';
import 'package:flutter/material.dart';

class FabList extends StatefulWidget {
  final Child child;

  const FabList({Key key, this.child}) : super(key: key);

  @override
  _FabListState createState() => _FabListState();
}

class _FabListState extends State<FabList> {
  double _opacity;

  @override
  void initState() {
    super.initState();
    _opacity = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
            child: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  tooltip: 'Log Nap Activity',
                  child: ListTile(
                    title: Icon(Icons.local_hotel),
                  ),
                  onPressed: () => debugPrint("Nap"),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
            child: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  tooltip: 'Log Changing Activity',
                  child: ListTile(
                    title: Icon(Icons.child_care),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogChange(
                            child: widget.child,
                            childId: widget.child.id,
                          ),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
            child: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  tooltip: 'Log Eat Activity',
                  child: ListTile(
                    title: Icon(Icons.restaurant),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogAte(
                                child: widget.child,
                                childId: widget.child.id,
                              ),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _opacity,
            child: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  tooltip: 'Log Drink Activity',
                  child: ListTile(
                    title: Icon(Icons.local_drink),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogDrink(
                                child: widget.child,
                                childId: widget.child.id,
                              ),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              tooltip: 'Add Activity',
              child: ListTile(
                title: Icon(Icons.menu),
              ),
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                });
              }),
        ),
      ],
    );
  }
}
