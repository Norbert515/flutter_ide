import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/ui/widget_editors/common_editors.dart';



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
      child: Container(
        height: 50,
        width: 100,
        color: color,
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
              sendUpdate(widget.propertyKey, ColorProperty(color: it));
            },
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   enableLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
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
