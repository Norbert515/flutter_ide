import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/base.dart';

// TODO doesn't work without reflection I think
// The idea is that every widget which has "child" parameter can be shoved in here and it works for now
class CustomWidgetElement extends WidgetElement with SingleChildElement{
  CustomWidgetElement({
    @required String id,
    this.widget,
  }) : super(id);

  final Widget widget;


  @override
  List<MProperty> get attributes => [];

  @override
  Widget generateWidget() {
    // TODO: implement generateWidget
    throw UnimplementedError();
  }

  @override
  String get name => widget.runtimeType.toString();

}

class CustomElementWidget extends StatefulWidget with ElementWidgetMixin {
  CustomElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CustomElementWidgetState createState() => _CustomElementWidgetState();
}

class _CustomElementWidgetState extends State<CustomElementWidget> with ElementWidgetStateMixin<CustomWidgetElement, CustomElementWidget> {

  @override
  Widget build(BuildContext context) {
    return wrapWithSelector(
        child: Container(
          child: getChildOrDragTarget(childId: element.childId),
        ));
  }

}
