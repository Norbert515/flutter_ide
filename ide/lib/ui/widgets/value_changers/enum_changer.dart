


import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/enum_properties.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';

class EnumChanger extends StatefulWidget {

  const EnumChanger({Key key, this.enumProperty, this.id, this.propertyKey}) : super(key: key);


  final EnumProperty enumProperty;
  final String id;
  final String propertyKey;

  @override
  _EnumChangerState createState() => _EnumChangerState();
}

class _EnumChangerState extends State<EnumChanger> with EditorMixin{

  String enumPrefix;

  // Without prefix
  String value;

  @override
  String get id => widget.id;

// TODO implement
  @override
  void initState() {
    super.initState();
    // Enums have at least 1 value
    enumPrefix = widget.enumProperty.stringValues[0].split(".")[0];
  }

  String _removePrefix(String name) {
    return name.split(".")[1];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: widget.enumProperty.stringValues.map(_removePrefix).map((string) {
       return DropdownMenuItem<String>(
         child: Text(string,),
         value: string,
       );
     }).toList(),
     onChanged: (string) {
       value = string;
       sendUpdate(widget.propertyKey, widget.enumProperty.copyWith("$enumPrefix.$value"));
       setState((){});

     },
    );
  }

}
