import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/widgets/property_editor.dart';

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
      sendUpdate(context, widget.propertyKey, StringProperty(controller.text));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        style: IDETheme.of(context).propertyChangerTheme.propertyNumericValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1)
        ),
        controller: controller,
      ),
    );
  }
}