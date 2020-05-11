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


class LinearProgressIndicatorElement extends WidgetElement with NoChildElementMixin {
  LinearProgressIndicatorElement({
    @required String id,
  }) :

      super(id);


  
  @override
  List<MProperty> get attributes => [
  ];

  @override
  Widget generateWidget() {
    return LinearProgressIndicatorElementWidget(
      id: id,
    );
  }

  factory LinearProgressIndicatorElement.fromMap(Map<String, dynamic> map) {
    return LinearProgressIndicatorElement(
        id: map["id"],
    );
  }

  @override
  String get name => "LinearProgressIndicator";

}


 class LinearProgressIndicatorElementWidget extends StatefulWidget with ElementWidgetMixin {
  LinearProgressIndicatorElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _LinearProgressIndicatorElementWidgetState createState() => _LinearProgressIndicatorElementWidgetState();
}

class _LinearProgressIndicatorElementWidgetState extends State<LinearProgressIndicatorElementWidget> with ElementWidgetStateMixin<LinearProgressIndicatorElement, LinearProgressIndicatorElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: LinearProgressIndicator(
        

        )
    );
  }

} 
  