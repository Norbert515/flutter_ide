import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/properties/icon_property.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/base.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/enums.dart';
import 'package:widget_maker_2_0/data/properties/decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/data/properties/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/data/properties/enum_properties.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/wrappers/wrappers.dart';


class TextFormFieldElement extends WidgetElement with NoChildElementMixin {
  TextFormFieldElement({
    @required String id,
  }) :

      super(id);


  
  @override
  List<MProperty> get attributes => [
  ];

  @override
  Widget generateWidget() {
    return TextFormFieldElementWidget(
      id: id,
    );
  }

  factory TextFormFieldElement.fromMap(Map<String, dynamic> map) {
    return TextFormFieldElement(
        id: map["id"],
    );
  }

  @override
  String get name => "TextFormField";

}


 class TextFormFieldElementWidget extends StatefulWidget with ElementWidgetMixin {
  TextFormFieldElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _TextFormFieldElementWidgetState createState() => _TextFormFieldElementWidgetState();
}

class _TextFormFieldElementWidgetState extends State<TextFormFieldElementWidget> with ElementWidgetStateMixin<TextFormFieldElement, TextFormFieldElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: TextFormField(
        

        )
    );
  }

} 
  