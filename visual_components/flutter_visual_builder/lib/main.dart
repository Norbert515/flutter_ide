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


  VmService vmService;

  @override
  Widget build(BuildContext context) {
    return VisualEditor();
  }
}

class AppWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return VisualScaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      floatingActionButton: VisualFloatingActionButton(onPressed: (){}),
    );
  }
}


class RootDraggable extends StatelessWidget {

  const RootDraggable({Key key, this.widgetAndSourceCode}) : super(key: key);

  final DynamicWidget widgetAndSourceCode;


  @override
  Widget build(BuildContext context) {
    return Draggable<DynamicWidget>(
      data: widgetAndSourceCode,
      feedback: widgetAndSourceCode.feedback,
      child: widgetAndSourceCode.widget,
    );
  }
}





/*
new Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("asd"),
              onPressed: () async {
                vmService = await vmServiceConnect("127.0.0.1", 55042);
                print(await vmService.getVersion());
              },
            ),
            RaisedButton(
              child: Text("Magic button"),
                onPressed: () async {
              //    vmService.reloadSources("isolates/199223766");
               //   print(await vmService.reloadSources("isolates/401496311"));
            }),
          ],
        ),
      ),
 */