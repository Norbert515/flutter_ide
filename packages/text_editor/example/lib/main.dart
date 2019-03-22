import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/services.dart' show rootBundle;
import 'package:text_editor/text_editor.dart';


void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  String code = await rootBundle.loadString("assets/code");
  runApp(MyApp(code: code,));
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key key, this.code}) : super(key: key);

  final String code;
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(code: code,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.code}) : super(key: key);

  final String code;
  
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo Home Page'),
      ),
      backgroundColor: Colors.black26,
      body: new Center(
       child: SingleChildScrollView(child: CodeShowcase(sourceCode: widget.code,)),
      ),
    );
  }
}

