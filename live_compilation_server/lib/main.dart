import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'temp_widget.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

import 'widget_converter.dart';
//import '../../pkg/widget_converter/lib/widget_converter.dart';
//import '/Users/Norbert/workspace/widget_maker_2_0/pkg/widget_converter/lib/widget_converter.dart';



void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {



  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  WebSocket _socket;

  @override
  void initState() {
    super.initState();

    initServer();
  }


  void initServer() async {

    int widgetPort = 9244;
    await HttpServer.bind(InternetAddress.loopbackIPv4, widgetPort).then((server) {
      print("Hot runner server is running on "
          "'http://${server.address.address}:$widgetPort/'");

      server.transform(WebSocketTransformer())
          .listen(handle);
    });
  }

  void handle(WebSocket webSocket) {
    _socket = webSocket;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidgetElementCompiler(
        child: buildL(),
      ),
    );
  }
}

class WidgetElementCompiler extends StatefulWidget {

  const WidgetElementCompiler({Key key, this.child, this.socket}) : super(key: key);
  final Widget child;
  final WebSocket socket;

  @override
  _WidgetElementCompilerState createState() => _WidgetElementCompilerState();
}

class _WidgetElementCompilerState extends State<WidgetElementCompiler> {

  Map convert() {
    print(walk(widget.child));
    return walk(widget.child);
  }

  @override
  void reassemble() {
    super.reassemble();
    //convert();
  }


  Map walk(Widget widget) {
    return convertWidget(widget);
    //return convert(widget);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var map = convert();
      var msg = json.encode(map);
      print("Sending off $msg");
      widget.socket?.add(msg);
    });
    return widget.child;
  }
}
