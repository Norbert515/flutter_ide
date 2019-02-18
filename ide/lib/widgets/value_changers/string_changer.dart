import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/widgets/property_editor.dart';
import 'value_changer.dart';


class StringWithConfirmChanger extends StatefulWidget with ValueChanger<String>{

  StringWithConfirmChanger({Key key, this.value, this.onChange}) : super(key: key);

  final String value;
  final ValueChanged<String> onChange;

  @override
  StringChangerWithConfirmState  createState() => StringChangerWithConfirmState();

}

class StringChangerWithConfirmState extends State<StringWithConfirmChanger> {

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
    controller.addListener(() {
      widget.onChange(controller.text);
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

class StringChanger extends StatefulWidget {

  StringChanger ({Key key, this.id, this.propertyKey, this.value}) : super(key: key);

  final String id;
  final String propertyKey;
  final String value;

  @override
  StringChangerState createState() => StringChangerState();

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