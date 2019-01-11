import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter_visual_builder/visual_components.dart';
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
    return Row(
      children: <Widget>[
        DragTarget<DynamicWidget>(
          builder: (context, it ,it2) {
            return Container(
                width: 200,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RootDraggable(widgetAndSourceCode: testWidget),
                    RootDraggable(widgetAndSourceCode: testWidget2),
                    RootDraggable(widgetAndSourceCode: testWidget3),
                  ],
                )
            );
          },
          onWillAccept: (it) => true,

        ),
        Expanded(child: AppWidget()),
      ],
    );
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

DynamicWidget testWidget = DynamicWidget(
    Container(
      color: Colors.green,
      width: 50,
      height: 100,
    ),
    'Container(color: Colors.green,width: 50,height: 100,)');

DynamicWidget testWidget2 = DynamicWidget(
    VisualFloatingActionButton(
      onPressed: (){},
    ),
    'Container(color: Colors.green,width: 50,height: 100,)');

DynamicWidget testWidget3 = DynamicWidget(
    Icon(Icons.add),
    'Container(color: Colors.green,width: 50,height: 100,)');

// Representation of a widget which can be moved around the screen
class DynamicWidget {

  DynamicWidget(this.widget, this.sourceCode, {Widget feedback}) : this.feedback = feedback ?? widget;

  DynamicWidget.empty(): widget = null, sourceCode = null, feedback = null;
  // The widget which should be moved around
  final Widget widget;

  // The source code of this widget
  final String sourceCode;

  /// The representation of the widget while being dragged around.
  ///
  /// Useful when widgets would normally expand to infinity
  final Widget feedback;
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