
import 'dart:io';

void main() {

  final pathToIcons = "D:\\flutter\\packages\\flutter\\lib\\src\\material\\icons.dart";
  final outPath = "lib\\data\\properties\\icon_property\\m_icons.dart";

  var file = File(pathToIcons);
  var outFile = File(outPath);

  assert(file.existsSync());

  List<String> lines = file.readAsLinesSync();

  int startingLine = 36;
  //int lastLine = 67;
  int lastLine = 2989;
  int gap = 3;
  int wordNum = 5;

  lines = lines.sublist(startingLine, lastLine);

  List<String> content = [];


  for(int i = 0; i < lastLine - startingLine; i+=3) {
    List<String> words = lines[i].split(" ");
    String name = words[wordNum];

    content.add(name);
  }

  List<String> codes = content.map((name) {
    return '''
    
  static const MIconData $name = const MIconData(
    icon: Icons.$name,
    name: "$name",
  );
    ''';
  }).toList();

  String result = '''
  
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/icon_property.dart';
  
class MIconContainer {
  
  //// GENERATED CODE - DO NOT TOUCH
  static const List<MIconData> all = [
    ${content.join(",\n    ")}
  ];
  
  static Map<IconData, String> iconDataToName = {
    ${content.map((it) => "Icons.$it: \"$it\"").join(",\n   ")}
  };
  ${codes.join()}
  
}
  ''';

  outFile.writeAsStringSync(result);


}