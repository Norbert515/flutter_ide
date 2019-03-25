import 'package:file_system_explorer/src/file_system_explorer_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return FileSystemExplorer(
      onPathSelected: (_) {},
    );
  }
}


