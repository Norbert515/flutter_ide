import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// This contains the properties as source code which would be lost otherwise when accessed at runtime.
///
/// For example:
///
/// return Container(
///   color: myColor,
/// );
///
/// Would evaluate to "myColor" during runtime, but we'd like to keep the variable, therefore
/// it is saved as:
///
/// Property("color", "myColor")
abstract class Property<T> {

  Property(this.data);

  String get sourceCode;

  T data;

  Map toMap() {
    return {
      "type": runtimeType.toString(),
      "property": getMapData()
    };
  }
  Map getMapData();
}


/// A property which can not be changed from the outside
///
/// It only contains the source code used to reconstruct the original
class UnknownProperty extends Property<String> {

  UnknownProperty({@required String sourceCode}) : super(sourceCode);


  @override
  String get sourceCode => data;

  @override
  Map getMapData() => {
    "sourceCode" : data,
  };
}



class AlignmentProperty extends Property<Alignment> {

 AlignmentProperty({Alignment alignment}): super(alignment);


  @override
  String get sourceCode => "Alignment(TODO)";

  @override
  Map getMapData() => {
    "x": data.x,
    "y": data.y,
  };
}


class ColorProperty extends Property<Color> {

  ColorProperty({Color color}): super(color);

  @override
  String get sourceCode => "Color(${data.value})";

  @override
  Map getMapData() => {
    "color": data.value,
  };
}