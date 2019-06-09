import 'dart:async';

import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/ui/list/child_list_screen.dart';
import 'package:baby_assistant/util/child_list_provider.dart';
import 'package:baby_assistant/util/child_provider.dart';
import 'package:baby_assistant/util/database_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/child.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(BabyAssistant());
}

class BabyAssistant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ChildListProvider()),
        ChangeNotifierProvider(builder: (_) => ChildProvider())
      ],
      child: isIOS
          ? CupertinoApp(
              title: 'Baby Assistant',
              home: AdaptiveMainScreen(),
              theme: CupertinoThemeData(
                  primaryColor: Colors.blue,
                  barBackgroundColor: Colors.blue,
                  scaffoldBackgroundColor: Colors.blueGrey,
                  textTheme: CupertinoTextThemeData(
                    primaryColor: Colors.white,
                  )),
              debugShowCheckedModeBanner: false,
            )
          : MaterialApp(
              title: 'Baby Assistant',
              home: AdaptiveMainScreen(),
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  appBarTheme: AppBarTheme(color: Colors.blue),
                  scaffoldBackgroundColor: Colors.blueGrey),
              debugShowCheckedModeBanner: false,
            ),
    );
  }
}

class AdaptiveMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(CupertinoIcons.home, color: Colors.white),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(CupertinoIcons.book, color: Colors.white),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Account',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(CupertinoIcons.person, color: Colors.white),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        tabBuilder: (context, index) {
          if (index == 0) {
            return CupertinoTabView(builder: (context) => ChildHome());
          } else if (index == 1) {
            return CupertinoTabView(builder: (context) => Search());
          } else {
            return CupertinoTabView(builder: (context) => Account());
          }
        },
      );
    } else {
      return ChildDetailScreen();
    }
  }
}

class ChildHome extends StatefulWidget {
  final Child child;

  const ChildHome({Key key, this.child}) : super(key: key);

  @override
  _ChildHomeState createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  String _savedChild;

  @override
  void initState() {
    super.initState();
//    _loadChildName();
  }

  Future<String> _loadChildName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('childName') != null &&
        preferences.getString('childName').isNotEmpty) {
      return _savedChild = preferences.getString("childName");
    } else {
      return _savedChild = "Empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context, listen: true);
    if (isIOS) {
      return FutureBuilder(
        future: _loadChildName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text('Home Page'),
              ),
              child: Text(snapshot.data),
            );
          } else {
            return Container();
          }
        },
      );
    } else {
      return Container();
    }
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Search'),
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final childListProvider =
        Provider.of<ChildListProvider>(context, listen: true);
    final childProvider = Provider.of<ChildProvider>(context, listen: true);
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Account Page'),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: childListProvider.logChildren.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        child: ListTile(
                          title: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      childListProvider
                                          .logChildren[index].firstName
                                          .substring(0, 1),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 9.0, left: 5.0),
                                  child: Text(
                                    childListProvider
                                        .logChildren[index].firstName,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.9),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            childProvider.setChild(childListProvider.logChildren[index]);
//                            Navigator.push(
//                                context,
//                                CupertinoPageRoute(
//                                  builder: (context) => ChildHome(
//                                        child: childListProvider
//                                            .logChildren[index],
//                                      ),
//                                ));
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

saveChild(String name) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("childNameKey", name);
}

class A {
  checkValue(Future<int> int) async {
    final val = await int;
    return val;
  }
}
