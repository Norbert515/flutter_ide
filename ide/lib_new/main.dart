import 'package:flutter/material.dart';
import 'package:ide/pages/welcome.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

import 'ui/desktop/choose_workspace_page.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<IDETheme>(
      value: IDETheme.standard(),
      updateShouldNotify: (it, i2) => false,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Widget Maker',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color(0xff3c3f41),
          accentColor:  Color(0xff0d293e),
          iconTheme: IconThemeData(
            color: Color(0xffbbbbbb),
          ),
          textTheme: TextTheme(
            body1: TextStyle(color: Color(0xffbbbbbb)),
          )
        ),
        routes: {
          '/welcome' : (context) => TutorialWelcome(),
        },

        home: ChooseWorkspacePage(),
      ),
    );
  }
}


