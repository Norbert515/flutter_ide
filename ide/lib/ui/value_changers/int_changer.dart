import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';
import 'package:ide/ui/widgets/general/text_fields.dart';

class IntChanger extends StatefulWidget {

  IntChanger({Key key, this.id, this.propertyKey, this.value}) : super(key: key);

  final String id;
  final String propertyKey;
  final int value;

  @override
  IntChangerState createState() => IntChangerState();

}

class IntChangerState extends State<IntChanger> with EditorMixin{


  int value;

  String get id => widget.id;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: NumericChangeableTextField(
        name: widget.propertyKey ,
        onUpdate: (it) {
          int rounded = it.round();
          sendUpdate(context, widget.propertyKey, IntProperty(data: rounded));
          setState(() {
            value = rounded;
          });
        },
        value: value.toDouble(),
      ),
    );
  }
}