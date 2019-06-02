import 'package:baby_assistant/ui/child_detail_screen.dart';
import 'package:baby_assistant/util/child_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;

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
    return ChangeNotifierProvider<ChildProvider>(
      builder: (context) => ChildProvider(),
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
          } else if (index == 2) {
            return CupertinoTabView(builder: (context) => Account());
          }
        },
      );
    } else {
      return ChildDetailScreen();
    }
  }
}

class ChildHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Home'),);
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Search'),);
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Account'),);
  }
}





