import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/widgets/widget_editors/property_changers/property_editor.dart';


class ColorChanger extends StatefulWidget {


  const ColorChanger({Key key, this.id, this.propertyKey, this.value}) : super(key: key);

  final String id;
  final String propertyKey;
  final Color value;

  @override
  ColorChangerState createState() {
    return new ColorChangerState();
  }
}

class ColorChangerState extends State<ColorChanger> with EditorMixin{


  Color color;

  @override
  String get id => widget.id;

  @override
  void initState() {
    super.initState();
    color = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickColor(context);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 30,
          width: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
        ),
      ),
    );
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder:  (_) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: color,
            colorPickerWidth: 400,
            onColorChanged: (it) {
              setState(() {
                color = it;
              });
              sendUpdate(context, widget.propertyKey, ColorProperty(color: it));
            },
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }



}
