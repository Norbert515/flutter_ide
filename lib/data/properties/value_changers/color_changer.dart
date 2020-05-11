import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/changers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';

import 'widgets/decoration.dart';
import 'widgets/nullable_changer.dart';

class ColorChanger extends StatelessValueChanger<Color> {
  ColorChanger(
      {Key key, Color value, ValueChanged<Color> onUpdate, bool nullable})
      : super(key: key, value: value, onUpdate: onUpdate, nullable: nullable);

  void _update({int r, int g, int b}) {
    Color color;
    if (value == null) {
      color = Color.fromARGB(255, 255, 255, 255);
    } else {
      color = value;
    }

    if (r != null) {
      onUpdate(color.withRed(r));
      return;
    } else if (g != null) {
      onUpdate(color.withGreen(g));
      return;
    } else if (b != null) {
      onUpdate(color.withBlue(b));
      return;
    }
  }

  void openPicker(BuildContext context) {
    showDialogAtContext(
      context: context,
      size: Size(500, 300),
      builder: (context) {
        return AlertDialog(
          elevation: 8,
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: value ?? Colors.white,
              onColorChanged: onUpdate,
              colorPickerWidth: 500.0,
              pickerAreaHeightPercent: 3.1,
              enableAlpha: true,
              displayThumbColor: true,
              paletteType: PaletteType.hsv,
            ),
          ),
        );
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: value ?? Colors.white,
              onColorChanged: onUpdate,
              pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   enableLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
          ),
        );
      },
    );
  }

  List<Widget> _getChildren(BuildContext context) {
    return [
      InkWell(
        onTap: () => openPicker(context),
        child: RoundContainer(
          width: 26,
          height: 26,
          color: value,
        ),
      ),
      SizedBox(
        width: 8,
      ),
      Expanded(
        child: IntrinsicHeight(
          child: TextField(
            controller: TextEditingController(text: "#${value.value.toRadixString(16).toString()}"),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
            ),
            onSubmitted: (it) {
              var i = int.tryParse(it, radix: 16);
              if(i == null) return;
              onUpdate(Color(i));

            },
          ),
        ),
      ),
      SizedBox(
        width: 8,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (value != null) ..._getChildren(context),
        AddOrRemoveButton<Color>(
          value: value,
          emptyConstructor: () => Colors.black,
          onChange: onUpdate,
        ),
      ],
    );
  }
}
