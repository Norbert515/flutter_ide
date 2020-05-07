import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/base.dart';

// TODO duplication with basic_properties
typedef ValueGetter<T> = T Function();

class InstancedWidgetElement extends WidgetElement with NoChildElementMixin{

  InstancedWidgetElement(String id, this.name, this.referenceId, this.otherProperties,) : super(id) {

    test = otherProperties();
  }

  List<MProperty> test;

  final String name;
  final String referenceId;
  final ValueGetter<List<MProperty>> otherProperties;

  @override
  List<MProperty> get attributes => test;

  @override
  Widget generateWidget() {
    return InstancedWidgetElementWidget(
      id: id,
    );
  }


}

class InstancedWidgetElementWidget extends StatefulWidget with ElementWidgetMixin {
  InstancedWidgetElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _InstancedWidgetElementWidgetState createState() => _InstancedWidgetElementWidgetState();
}

class _InstancedWidgetElementWidgetState extends State<InstancedWidgetElementWidget> with ElementWidgetStateMixin<InstancedWidgetElement, InstancedWidgetElementWidget > {

  @override
  Widget getChildOrDragTarget({String childId, SlotData data, WidgetWrapper widgetWrapper}) {
    return widgetBoard.getWidgetElement(childId)?.generateWidget() ?? Container(color: Colors.red, width: 100, height: 100);
    //return Container(color: Colors.red, width: 100, height: 100);
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithSelector(
        child: Container(
          child: getChildOrDragTarget(childId: element.referenceId),
        ));
  }

}