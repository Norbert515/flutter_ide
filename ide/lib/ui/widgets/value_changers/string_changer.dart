import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';

class StringChanger extends StatefulWidget {

  StringChanger ({Key key, this.id, this.propertyKey, this.value}) : super(key: key);

  final String id;
  final String propertyKey;
  final String value;

  @override
  StringChangerState createState() {
    return new StringChangerState();
  }
}

class StringChangerState extends State<StringChanger> with EditorMixin {
  final TextEditingController controller = TextEditingController();

  String get id => widget.id;

  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
    controller.addListener(() {
      sendUpdate(widget.propertyKey, StringProperty(controller.text));
    });

  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}