import 'dart:isolate';


Future<List<String>> getEnumValues(String enumName) async {
  final uri = Uri.dataFromString(
    '''
    import "dart:isolate";
    import 'package:flutter/material.dart';
    import "dart:ui";
    void main(_, SendPort port) {
      print("Hello World");
      List<$enumName> values = $enumName.values;
      port.send(values.map((it) => it.toString()..split(".")[1]).join(","));
    }
    ''',
    mimeType: 'application/dart',
  );

  final port = ReceivePort();
  final isolate = await Isolate.spawnUri(uri, [], port.sendPort, automaticPackageResolution: true);
  final String response = await port.first;

  port.close();
  isolate.kill();

  print(response);
}