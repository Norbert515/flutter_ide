import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';
import 'package:widget_maker_2_0/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/properties/value_changers/widgets/number_changer.dart';

class CanvasSizeChanger extends StatelessValueChanger<CanvasSize>{

  CanvasSizeChanger({Key key, CanvasSize canvasSize, ValueChanged<CanvasSize> onUpdate}) :
        super(key: key, value: canvasSize, onUpdate: onUpdate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<CanvasSize>(
          value: CanvasSize.sizes.containsKey(value)? value: null,
          items: CanvasSize.sizes.keys.map((canvasSize) {
            return DropdownMenuItem<CanvasSize>(
              value: canvasSize,
              child: Text(CanvasSize.sizes[canvasSize]),
            );
          }).toList(),
          onChanged: (it) {
            onUpdate(it);
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: NumberChanger(
                value: value.width,
                name: "width",
                onUpdate: (it) {
                  onUpdate(value.copyWith(width: it));
                },
              ),
            ),
            Expanded(
              child: NumberChanger(
                value: value.height,
                name: "height",
                onUpdate: (it) {
                  onUpdate(value.copyWith(height: it));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
