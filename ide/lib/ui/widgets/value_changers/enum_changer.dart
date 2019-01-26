


import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/enum_properties.dart';

class EnumChanger extends StatefulWidget {

  const EnumChanger({Key key, this.enumProperty}) : super(key: key);

  final EnumProperty enumProperty;

  @override
  _EnumChangerState createState() => _EnumChangerState();
}

class _EnumChangerState extends State<EnumChanger> {

  String enumPrefix;

// TODO implement
  @override
  void initState() {
    super.initState();
    // Enums have at least 1 value
    enumPrefix = widget.enumProperty.stringValues[0].split(".")[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
     items: widget.enumProperty.stringValues.map((string) {
       return DropdownMenuItem<String>(
         child: Text(string),
         value: string,
       );
     }).toList(),
     onChanged: (string) {
       print("Changed to $string");
     },
    );
  }
}
