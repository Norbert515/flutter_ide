import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter_visual_builder/dynamic_widget.dart';
import 'package:flutter_visual_builder/editor_widget.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
import 'package:vm_service_lib/vm_service_lib.dart';

import 'package:vm_service_lib/vm_service_lib_io.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  // TODO
  // In the end the source code should be accessible like this
  void todo() {
    VisualScaffold visualScaffold = VisualScaffold();
    String source = visualScaffold.buildSourceCode();
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  // Can do fancy stuff with this
  VmService vmService;

  @override
  Widget build(BuildContext context) {
    return VisualEditor();
  }
}



