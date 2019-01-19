import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


enum PropertyType{
  unknown,
  alignment,
  color
}

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

  PropertyType get type;

  Map toMap() {
    return {
      "type": type.toString(),
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
  UnknownProperty.fromMap(Map map): super(map["sourceCode"]);


  @override
  String get sourceCode => data;

  @override
  Map getMapData() => {
    "sourceCode" : data,
  };

  @override
  PropertyType get type => PropertyType.unknown;
}



class AlignmentProperty extends Property<Alignment> {

 AlignmentProperty({Alignment alignment}): super(alignment);
 AlignmentProperty.fromMap(Map map): super(Alignment(map["x"], map["y"]));


  @override
  String get sourceCode => "Alignment(TODO)";

  @override
  Map getMapData() => {
    "x": data.x,
    "y": data.y,
  };

  @override
  PropertyType get type => PropertyType.alignment;
}


class ColorProperty extends Property<Color> {

  ColorProperty({Color color}): super(color);
  ColorProperty.fromMap(Map map): super(Color(map["color"]));

  @override
  String get sourceCode => "Color(${data.value})";

  @override
  Map getMapData() => {
    "color": data.value,
  };

  @override
  PropertyType get type => PropertyType.color;
}