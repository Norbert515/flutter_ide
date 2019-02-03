import 'package:flutter/material.dart';
import 'package:ide/dependencies/property_editor_provider.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/tutorial/welcome.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:ide/ui/home_page.dart';
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
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TutorialWelcome(),
      ),
    );
  }
}


