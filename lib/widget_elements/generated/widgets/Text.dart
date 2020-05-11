import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/properties/icon_property.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/base.dart';
import 'package:widget_maker_2_0/widget_elements/generated/properties/enums.dart';
import 'package:widget_maker_2_0/properties/decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/properties/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/properties/enum_properties.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/widget_elements/wrappers/wrappers.dart';


class TextElement extends WidgetElement with NoChildElementMixin {
  TextElement({
    @required String id,
    String data,
    TextOverflow overflow,
    TextAlign textAlign,
    TextStyle style,
  }) :
    data = MStringProperty(
        value: data?? "Hello",
        name: "data",
        isRequired: true,
        isNamed: false,
        defaultValue: "Hello"
    ),

    overflow = MTextOverflowProperty(
        value: overflow?? TextOverflow.clip,
        name: "overflow",
        defaultValue: TextOverflow.clip
    ),

    textAlign = MTextAlignProperty(
        value: textAlign?? TextAlign.start,
        name: "textAlign",
        defaultValue: TextAlign.start
    ),

    style = MTextStyleProperty(
        value: style?? const TextStyle(),
        name: "style",
        defaultValue: const TextStyle()
    ),


      super(id);

    final MStringProperty data;
    final MTextOverflowProperty overflow;
    final MTextAlignProperty textAlign;
    final MTextStyleProperty style;

  
  @override
  List<MProperty> get attributes => [
    data,
    overflow,
    textAlign,
    style,
  ];

  @override
  Widget generateWidget() {
    return TextElementWidget(
      id: id,
    );
  }

  factory TextElement.fromMap(Map<String, dynamic> map) {
    return TextElement(
        id: map["id"],
        data: map["data"],
        overflow: map["overflow"],
        textAlign: map["textAlign"],
        style: map["style"],
    );
  }

  @override
  String get name => "Text";

}


 class TextElementWidget extends StatefulWidget with ElementWidgetMixin {
  TextElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _TextElementWidgetState createState() => _TextElementWidgetState();
}

class _TextElementWidgetState extends State<TextElementWidget> with ElementWidgetStateMixin<TextElement, TextElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Text(
        
         element.data.value,
         overflow: element.overflow.value,
         textAlign: element.textAlign.value,
         style: element.style.value,
        )
    );
  }

} 
  