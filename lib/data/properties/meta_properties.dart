import 'package:code_builder/code_builder.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/canvas_size_changer.dart';
import 'package:widget_maker_2_0/data/string_builder.dart';
import 'package:flutter/material.dart';
import 'basic_properties.dart';


class CanvasSize {

  static Map<CanvasSize, String> sizes = {
    const CanvasSize(width: 800, height: 800): "Default",
    const CanvasSize(width: 411, height: 731): "Pixel 2",
    const CanvasSize(width: 411, height: 823): "Pixel 2 XL",
    const CanvasSize(width: 1440, height: 1024): "Desktop",
    const CanvasSize(width: 834, height: 1112): "iPad Pro 10.5\"",

  };

  final double width;
  final double height;

  get size => Size(width, height);

  const CanvasSize({this.width, this.height});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CanvasSize &&
              runtimeType == other.runtimeType &&
              width == other.width &&
              height == other.height;

  @override
  int get hashCode =>
      width.hashCode ^
      height.hashCode;


  CanvasSize copyWith({double width, double height}) {
    return CanvasSize(
      width: width?? this.width,
      height: height?? this.height,
    );
  }

}

class MCanvasSizeProperty extends MProperty<CanvasSize> with SingleChangerMixin{
  MCanvasSizeProperty ({@required CanvasSize value, @required String name})
      : super(value: value, name: name, isNamed: true, isRequired: false);


  @override
  MCanvasSizeProperty copy() {
    return MCanvasSizeProperty(
      value: value,
      name: name,
    );
  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return CanvasSizeChanger(
      canvasSize: value,
      onUpdate: (newValue) {
        updateValue(newValue, context, id);
      },
    );
  }


  @override
  Expression toCode() {
    assert(false);
  }
}