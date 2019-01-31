import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';


class BoolChanger extends StatefulWidget {

  BoolChanger ({Key key, this.id, this.propertyKey, this.value}) : super(key: key);

  final String id;
  final String propertyKey;
  final bool value;

  @override
  BoolChangerState createState() {
    return new BoolChangerState();
  }
}

class BoolChangerState extends State<BoolChanger> with EditorMixin {

  String get id => widget.id;

  bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;

  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (value) {
        sendUpdate(context, widget.propertyKey, BoolProperty(value));
        setState(() {
          this.value = value;
        });
      }
    );
  }
}