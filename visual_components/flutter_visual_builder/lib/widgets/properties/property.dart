import 'package:flutter/material.dart';
import 'package:ide/utils/string_builder.dart';
import 'package:meta/meta.dart';


enum PropertyType{
  unknown,
  alignment,
  color,
  double,
  int,
  string,
  bool,
  edgeInserts,
  boxConstraints,
  mainAxisAlignment,
  crossAxisAlignment,
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

  void fillSourceCode(StringBuilder builder);

  final T data;

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
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent(data);
  }

  @override
  Map getMapData() => {
    "sourceCode" : data,
  };

  @override
  PropertyType get type => PropertyType.unknown;


}



// TODO this uses the specific Alignment subclass of AlignmentGeometry. 
// Think of something ot make it work with that instead
class AlignmentProperty extends Property<Alignment> {

 AlignmentProperty({Alignment alignment}): super(alignment);
 AlignmentProperty.fromMap(Map map): super(Alignment(map["x"], map["y"]));


   @override
   void fillSourceCode(StringBuilder builder) {
     builder.writeNoIndent("Alignment(${data.x}, ${data.y})");
   }

  @override
  Map getMapData() => {
    "x": data.x,
    "y": data.y,
  };

  @override
  PropertyType get type => PropertyType.alignment;


}


// TODO all properties should be able to hold null
class ColorProperty extends Property<Color> {

  ColorProperty({Color color}): super(color);
  ColorProperty.fromMap(Map map): super(Color(map["color"]));


  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent("Color(0x${data.value.toRadixString(16)})");
  }

  @override
  Map getMapData() => {
    "color": data?.value,
  };

  @override
  PropertyType get type => PropertyType.color;


}
// TODO name collision with diagnostics
class DoubleProperty extends Property<double> {
  DoubleProperty({double data}) : super(data);
  DoubleProperty.fromMap(Map map): super(map["double"]);


  @override
  Map getMapData() => {
    "double": data,
  };

  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent(data.toString());
  }


  @override
  PropertyType get type => PropertyType.double;


}

class IntProperty extends Property<int> {
  IntProperty({int data}) : super(data);
  IntProperty.fromMap(Map map): super(map["int"]);


  @override
  Map getMapData() => {
    "int": data,
  };

  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent(data.toString());
  }


  @override
  PropertyType get type => PropertyType.int;


}

class EdgeInsertsProperty extends Property<EdgeInsets> {
  EdgeInsertsProperty({EdgeInsets data}) : super(data);
  EdgeInsertsProperty.fromMap(Map map): super(EdgeInsets.only(
    left: map["left"] ?? 0,
    right: map["right"] ?? 0,
    top: map["top"] ?? 0,
    bottom: map["bottom"] ?? 0,
  ));


  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent("EdgeInsets.only(\n");
    builder.addIndent();
    builder.write("left: ${data.left},\n");
    builder.write("right: ${data.right},\n");
    builder.write("top: ${data.top},\n");
    builder.write("bottom: ${data.bottom},\n");
    builder.removeIndent();
    builder.write(")");
  }

  @override
  Map getMapData() => {
    "left": data.left,
    "right": data.right,
    "top": data.top,
    "bottom": data.bottom,
  }; 


  @override
  PropertyType get type => PropertyType.edgeInserts;


}


class BoxConstraintsProperty extends Property<BoxConstraints> {
  BoxConstraintsProperty({BoxConstraints data}) : super(data);
  BoxConstraintsProperty.fromMap(Map map) : super(BoxConstraints(
    minWidth: double.tryParse(map['minWidth'])?? 0,
    maxWidth: double.tryParse(map['maxWidth'])?? double.infinity,
    minHeight: double.tryParse(map['minHeight'])?? 0,
    maxHeight: double.tryParse(map['maxHeight'])?? double.infinity,
  ));
  
  
  @override
  Map getMapData() => {
    'minWidth': data.minWidth.toString(),
    'maxWidth': data.maxWidth.toString(),
    'minHeight': data.minHeight.toString(),
    'maxHeight': data.maxHeight.toString(),
  };

  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent("BoxConstraints(\n");
    builder.addIndent();
    builder.write("minWidth: ${data.minWidth},\n");
    builder.write("maxWidth: ${data.maxWidth},\n");
    builder.write("minHeight: ${data.minHeight},\n");
    builder.write("maxHeight: ${data.maxHeight},\n");
    builder.removeIndent();
    builder.write(")");
  }


  @override
  PropertyType get type => PropertyType.boxConstraints;

  
}

class StringProperty extends Property<String> {
  StringProperty(String data): super(data);
  StringProperty.fromMap(Map map) : super(map['data']);

  @override
  Map getMapData() => {
    'data': data,
  };

  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent('"$data"');
  }


  @override
  PropertyType get type => PropertyType.string;


}



class BoolProperty extends Property<bool> {

  BoolProperty(bool data): super(data);
  BoolProperty.fromMap(Map map): super(map['data'] == 'true'? true: false);
  @override
  void fillSourceCode(StringBuilder builder) {
    builder.writeNoIndent(data.toString());
  }

  @override
  Map getMapData() => {
    'data': data.toString(),
  };

  @override
  PropertyType get type => PropertyType.bool;

}

